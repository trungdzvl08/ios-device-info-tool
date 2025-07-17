#!/bin/bash

# iOS Device Info Tool - Deployment Script
# This script helps deploy the application to various hosting platforms

set -e

echo "🚀 iOS Device Info Tool - Deployment Script"
echo "============================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Check if required tools are installed
check_requirements() {
    print_step "Checking requirements..."
    
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 18+ first."
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please install npm first."
        exit 1
    fi
    
    NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        print_error "Node.js version 18+ is required. Current version: $(node --version)"
        exit 1
    fi
    
    print_status "Requirements check passed ✅"
}

# Setup environment
setup_environment() {
    print_step "Setting up environment..."
    
    if [ ! -f ".env.local" ]; then
        if [ -f ".env.example" ]; then
            cp .env.example .env.local
            print_warning "Created .env.local from .env.example. Please update it with your configuration."
        else
            print_error ".env.example not found. Please create environment configuration."
            exit 1
        fi
    fi
    
    print_status "Environment setup completed ✅"
}

# Install dependencies
install_dependencies() {
    print_step "Installing dependencies..."
    
    npm ci --production=false
    
    print_status "Dependencies installed ✅"
}

# Build application
build_application() {
    print_step "Building application..."
    
    # Clean previous build
    rm -rf .next
    rm -rf out
    
    # Build Next.js application
    npm run build
    
    print_status "Application built successfully ✅"
}

# Run tests (if available)
run_tests() {
    print_step "Running tests..."
    
    if npm run test --silent 2>/dev/null; then
        print_status "Tests passed ✅"
    else
        print_warning "No tests found or tests failed. Continuing deployment..."
    fi
}

# Generate deployment package
create_deployment_package() {
    print_step "Creating deployment package..."
    
    # Create deployment directory
    mkdir -p deployment
    
    # Copy necessary files
    cp -r .next deployment/
    cp -r public deployment/
    cp package.json deployment/
    cp package-lock.json deployment/
    cp next.config.ts deployment/
    
    # Copy environment file if exists
    if [ -f ".env.local" ]; then
        cp .env.local deployment/.env.production
    fi
    
    # Create production package.json
    cat > deployment/package.json << EOF
{
  "name": "ios-device-info",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "start": "next start",
    "postinstall": "npm run build"
  },
  "dependencies": $(node -p "JSON.stringify(require('./package.json').dependencies, null, 2)")
}
EOF
    
    print_status "Deployment package created ✅"
}

# Deploy to Vercel
deploy_vercel() {
    print_step "Deploying to Vercel..."
    
    if ! command -v vercel &> /dev/null; then
        print_warning "Vercel CLI not found. Installing..."
        npm install -g vercel
    fi
    
    vercel --prod
    
    print_status "Deployed to Vercel ✅"
}

# Deploy to Netlify
deploy_netlify() {
    print_step "Deploying to Netlify..."
    
    if ! command -v netlify &> /dev/null; then
        print_warning "Netlify CLI not found. Installing..."
        npm install -g netlify-cli
    fi
    
    # Build for static export
    npm run build
    npm run export
    
    netlify deploy --prod --dir=out
    
    print_status "Deployed to Netlify ✅"
}

# Deploy with Docker
deploy_docker() {
    print_step "Building Docker image..."
    
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    # Build Docker image
    docker build -t ios-device-info:latest .
    
    print_status "Docker image built ✅"
    
    # Option to run locally
    read -p "Do you want to run the container locally? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_step "Starting Docker container..."
        docker run -d -p 3000:3000 --name ios-device-info ios-device-info:latest
        print_status "Container started at http://localhost:3000 ✅"
    fi
}

# Deploy to VPS
deploy_vps() {
    print_step "Preparing VPS deployment..."
    
    read -p "Enter VPS hostname/IP: " VPS_HOST
    read -p "Enter SSH username: " SSH_USER
    
    if [ -z "$VPS_HOST" ] || [ -z "$SSH_USER" ]; then
        print_error "VPS hostname and SSH username are required."
        exit 1
    fi
    
    # Create deployment archive
    tar -czf ios-device-info.tar.gz deployment/
    
    # Upload to VPS
    scp ios-device-info.tar.gz $SSH_USER@$VPS_HOST:~/
    
    # Deploy on VPS
    ssh $SSH_USER@$VPS_HOST << 'EOF'
        # Extract and setup
        tar -xzf ios-device-info.tar.gz
        cd deployment
        
        # Install dependencies
        npm ci --production
        
        # Install PM2 if not exists
        if ! command -v pm2 &> /dev/null; then
            npm install -g pm2
        fi
        
        # Stop existing process
        pm2 stop ios-device-info || true
        pm2 delete ios-device-info || true
        
        # Start new process
        pm2 start npm --name "ios-device-info" -- start
        pm2 save
        pm2 startup
        
        echo "Deployment completed!"
EOF
    
    print_status "Deployed to VPS ✅"
}

# Main deployment menu
main_menu() {
    echo
    echo "Select deployment option:"
    echo "1) Vercel (Recommended)"
    echo "2) Netlify"
    echo "3) Docker"
    echo "4) VPS/Server"
    echo "5) Build only"
    echo "6) Exit"
    echo
    
    read -p "Enter your choice (1-6): " choice
    
    case $choice in
        1)
            deploy_vercel
            ;;
        2)
            deploy_netlify
            ;;
        3)
            deploy_docker
            ;;
        4)
            deploy_vps
            ;;
        5)
            print_status "Build completed. Files are ready in .next directory."
            ;;
        6)
            print_status "Deployment cancelled."
            exit 0
            ;;
        *)
            print_error "Invalid choice. Please select 1-6."
            main_menu
            ;;
    esac
}

# Cleanup function
cleanup() {
    print_step "Cleaning up temporary files..."
    rm -f ios-device-info.tar.gz
    print_status "Cleanup completed ✅"
}

# Main execution
main() {
    check_requirements
    setup_environment
    install_dependencies
    build_application
    run_tests
    create_deployment_package
    
    main_menu
    
    cleanup
    
    echo
    print_status "🎉 Deployment process completed!"
    echo
    echo "Next steps:"
    echo "1. Update your environment variables in production"
    echo "2. Test your deployment"
    echo "3. Set up monitoring and logging"
    echo "4. Configure your domain (if applicable)"
    echo
}

# Handle script interruption
trap cleanup EXIT

# Run main function
main "$@"
