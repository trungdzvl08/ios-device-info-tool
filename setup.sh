#!/bin/bash

# iOS Device Info Tool - Setup Script
# This script helps set up the development environment

set -e

echo "🛠️  iOS Device Info Tool - Setup Script"
echo "========================================"

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

# Generate random encryption key
generate_encryption_key() {
    openssl rand -hex 16 2>/dev/null || head -c 32 /dev/urandom | xxd -p -c 32 | head -1
}

# Setup environment variables
setup_environment() {
    print_step "Setting up environment variables..."
    
    if [ ! -f ".env.local" ]; then
        print_status "Creating .env.local file..."
        
        # Generate encryption key
        ENCRYPTION_KEY=$(generate_encryption_key)
        
        cat > .env.local << EOF
# Telegram Bot Configuration
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
TELEGRAM_ADMIN_ID=your_admin_chat_id_here

# Encryption Key (auto-generated)
ENCRYPTION_KEY=${ENCRYPTION_KEY}

# Next.js Configuration
NEXT_PUBLIC_APP_URL=http://localhost:3000
EOF
        
        print_status "Environment file created with auto-generated encryption key ✅"
        print_warning "Please update TELEGRAM_BOT_TOKEN and TELEGRAM_ADMIN_ID in .env.local"
    else
        print_status "Environment file already exists ✅"
    fi
}

# Install dependencies
install_dependencies() {
    print_step "Installing dependencies..."
    
    if command -v npm &> /dev/null; then
        npm install
        print_status "Dependencies installed with npm ✅"
    elif command -v yarn &> /dev/null; then
        yarn install
        print_status "Dependencies installed with yarn ✅"
    else
        print_error "Neither npm nor yarn found. Please install Node.js first."
        exit 1
    fi
}

# Create necessary directories
create_directories() {
    print_step "Creating necessary directories..."
    
    mkdir -p logs
    mkdir -p ssl
    mkdir -p deployment
    
    print_status "Directories created ✅"
}

# Setup Git hooks (if Git is available)
setup_git_hooks() {
    if command -v git &> /dev/null && [ -d ".git" ]; then
        print_step "Setting up Git hooks..."
        
        # Pre-commit hook
        cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
# Run linting and type checking before commit
npm run lint --silent || exit 1
npm run type-check --silent || exit 1
EOF
        
        chmod +x .git/hooks/pre-commit
        print_status "Git hooks setup ✅"
    fi
}

# Create SSL certificates for development
create_dev_ssl() {
    print_step "Creating development SSL certificates..."
    
    if command -v openssl &> /dev/null; then
        if [ ! -f "ssl/cert.pem" ] || [ ! -f "ssl/key.pem" ]; then
            openssl req -x509 -newkey rsa:4096 -keyout ssl/key.pem -out ssl/cert.pem -days 365 -nodes -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"
            print_status "Development SSL certificates created ✅"
        else
            print_status "SSL certificates already exist ✅"
        fi
    else
        print_warning "OpenSSL not found. SSL certificates not created."
    fi
}

# Setup development database (if needed)
setup_database() {
    print_step "Checking database requirements..."
    print_status "No database required for this application ✅"
}

# Run initial build
initial_build() {
    print_step "Running initial build..."
    
    npm run build
    print_status "Initial build completed ✅"
}

# Create systemd service file (for Linux servers)
create_systemd_service() {
    if [ "$1" = "--systemd" ] && [ -f "/etc/systemd/system/" ]; then
        print_step "Creating systemd service file..."
        
        cat > ios-device-info.service << EOF
[Unit]
Description=iOS Device Info Tool
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=$(pwd)
Environment=NODE_ENV=production
ExecStart=/usr/bin/npm start
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
        
        print_status "Systemd service file created. Copy to /etc/systemd/system/ to use."
    fi
}

# Display setup summary
display_summary() {
    echo
    echo "🎉 Setup completed successfully!"
    echo "================================"
    echo
    echo "Next steps:"
    echo "1. Update .env.local with your Telegram bot configuration"
    echo "2. Run 'npm run dev' to start development server"
    echo "3. Visit http://localhost:3000 to test the application"
    echo "4. Use './deploy.sh' when ready to deploy"
    echo
    echo "Configuration files:"
    echo "- .env.local: Environment variables"
    echo "- nginx.conf: Nginx configuration for production"
    echo "- docker-compose.yml: Docker deployment"
    echo "- Dockerfile: Container configuration"
    echo
    echo "Useful commands:"
    echo "- npm run dev: Start development server"
    echo "- npm run build: Build for production"
    echo "- npm run start: Start production server"
    echo "- ./deploy.sh: Deploy to various platforms"
    echo
}

# Main setup function
main() {
    setup_environment
    install_dependencies
    create_directories
    setup_git_hooks
    create_dev_ssl
    setup_database
    initial_build
    create_systemd_service "$@"
    display_summary
}

# Handle script interruption
cleanup() {
    print_warning "Setup interrupted. You may need to run this script again."
}

trap cleanup EXIT

# Run main function with all arguments
main "$@"
