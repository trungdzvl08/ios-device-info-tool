import type { NextConfig } from 'next'

const nextConfig: NextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'images.pexels.com',
        pathname: '/photos/**',
      },
    ],
  },
  async headers() {
    return [
      {
        source: '/api/udid',
        headers: [
          {
            key: 'Content-Type',
            value: 'application/x-apple-aspen-config',
          },
          {
            key: 'Content-Disposition',
            value: 'attachment; filename="device-info.mobileconfig"',
          },
          {
            key: 'Cache-Control',
            value: 'no-cache, no-store, must-revalidate',
          },
          {
            key: 'Pragma',
            value: 'no-cache',
          },
          {
            key: 'Expires',
            value: '0',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
        ],
      },
    ];
  },
}

export default nextConfig
