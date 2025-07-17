# 📱 iOS Device Info Tool

<div align="center">

![iOS Device Info Tool](https://img.shields.io/badge/iOS-Device%20Info%20Tool-blue?style=for-the-badge&logo=apple)
![Next.js](https://img.shields.io/badge/Next.js-15.3.2-black?style=for-the-badge&logo=next.js)
![TypeScript](https://img.shields.io/badge/TypeScript-5.7.2-blue?style=for-the-badge&logo=typescript)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**Công cụ chuyên nghiệp để lấy thông tin chi tiết thiết bị iPhone và iPad thông qua iOS Configuration Profile**

[🚀 Demo Live](#) • [📖 Tài liệu](#tài-liệu) • [🐛 Báo lỗi](https://github.com/your-username/ios-device-info-tool/issues) • [💡 Đóng góp](#đóng-góp)

</div>

---

## ✨ Tính năng nổi bật

### 🔍 **Thu thập thông tin toàn diện**
- **UDID** (Unique Device Identifier) - Mã định danh duy nhất
- **Serial Number** - Số seri thiết bị
- **IMEI/MEID** - Mã nhận dạng thiết bị di động
- **Device Name** - Tên thiết bị do người dùng đặt
- **Model & Marketing Name** - Thông tin model chi tiết
- **iOS Version & Build** - Phiên bản hệ điều hành
- **MAC Addresses** - WiFi, Bluetooth, Ethernet
- **Device Capacity** - Dung lượng lưu trữ
- **Battery Level** - Mức pin hiện tại
- **Carrier Information** - Thông tin nhà mạng
- **Phone Number** - Số điện thoại (nếu có)

### 🎨 **Giao diện đẹp mắt**
- **Responsive Design** - Tương thích mọi thiết bị
- **Modern UI/UX** - Thiết kế hiện đại với Tailwind CSS
- **Dark/Light Mode** - Hỗ trợ chế độ sáng/tối
- **Smooth Animations** - Hiệu ứng mượt mà
- **Mobile-First** - Tối ưu cho thiết bị di động

### 🔒 **Bảo mật cao**
- **Mã hóa dữ liệu** - Telegram token được mã hóa
- **Không lưu trữ** - Không lưu thông tin cá nhân
- **HTTPS Required** - Bắt buộc kết nối an toàn
- **Rate Limiting** - Giới hạn tần suất truy cập
- **Input Validation** - Kiểm tra dữ liệu đầu vào

### 📱 **Trải nghiệm tự động**
- **Auto Download** - Tự động tải configuration profile
- **Auto Install Guide** - Hướng dẫn cài đặt chi tiết
- **Auto Redirect** - Tự động chuyển hướng sau cài đặt
- **Auto Display** - Hiển thị kết quả tự động

### 🔔 **Thông báo Telegram**
- **Real-time Notifications** - Thông báo thời gian thực
- **Detailed Info** - Thông tin chi tiết về thiết bị
- **Admin Dashboard** - Bảng điều khiển cho admin
- **Error Tracking** - Theo dõi lỗi tự động

---

## 🚀 Cài đặt nhanh

### Yêu cầu hệ thống
- **Node.js** 18.0.0 trở lên
- **npm** 8.0.0 trở lên
- **Git** (để clone repository)

### 1. Clone repository
```bash
git clone https://github.com/your-username/ios-device-info-tool.git
cd ios-device-info-tool
```

### 2. Cài đặt tự động
```bash
chmod +x setup.sh
./setup.sh
```

### 3. Cấu hình môi trường
Chỉnh sửa file `.env.local`:
```env
# Telegram Bot Configuration
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
TELEGRAM_ADMIN_ID=your_admin_chat_id_here

# Encryption Key (auto-generated)
ENCRYPTION_KEY=your_32_character_encryption_key_here

# App Configuration
NEXT_PUBLIC_APP_URL=https://yourdomain.com
```

### 4. Chạy ứng dụng
```bash
npm run dev
```

Truy cập: `http://localhost:8000`

---

## 📖 Tài liệu

### 🔧 Cấu hình Telegram Bot

#### Tạo Telegram Bot
1. Mở Telegram và tìm `@BotFather`
2. Gửi lệnh `/newbot`
3. Đặt tên cho bot của bạn
4. Lấy **Bot Token**

#### Lấy Chat ID
1. Gửi tin nhắn cho bot của bạn
2. Truy cập: `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`
3. Tìm `chat.id` trong response

#### Test kết nối
```bash
node -e "
const { testTelegramConnection } = require('./src/lib/telegram.ts');
testTelegramConnection().then(result => console.log('Test result:', result));
"
```

### 📱 Cách sử dụng

#### Cho người dùng cuối:
1. **Truy cập website**
2. **Nhấn "Tải cấu hình ngay"**
3. **Cài đặt profile trên iOS:**
   - Settings → General → VPN & Device Management
   - Chọn profile vừa tải → Install
4. **Xem kết quả tự động hiển thị**

#### Cho admin:
- Nhận thông báo tự động qua Telegram
- Theo dõi logs trong console
- Quản lý thông qua health check endpoint

---

## 🏗️ Cấu trúc dự án

```
ios-device-info-tool/
├── 📁 src/
│   ├── 📁 app/                    # Next.js App Router
│   │   ├── 📁 api/
│   │   │   ├── 📁 device-info/    # API xử lý thông tin thiết bị
│   │   │   ├── 📁 health/         # Health check endpoint
│   │   │   └── 📁 udid/           # API tạo configuration profile
│   │   ├── 📁 udid/               # Trang tải cấu hình
│   │   │   └── 📁 result/         # Trang hiển thị kết quả
│   │   ├── 📄 layout.tsx          # Layout chính
│   │   ├── 📄 page.tsx            # Trang chủ
│   │   └── 📄 globals.css         # CSS toàn cục
│   ├── 📁 lib/
│   │   ├── 📄 config.ts           # Quản lý cấu hình bảo mật
│   │   ├── 📄 logger.ts           # Hệ thống logging
│   │   ├── 📄 telegram.ts         # Telegram integration
│   │   └── 📄 utils.ts            # Utilities
│   └── 📁 components/             # React components
├── 📁 public/                     # Static files
├── 📄 index.html                  # HTML thuần (standalone)
├── 📄 result.html                 # Trang kết quả HTML thuần
├── 📄 Dockerfile                  # Docker configuration
├── 📄 docker-compose.yml          # Docker orchestration
├── 📄 nginx.conf                  # Nginx configuration
├── 📄 vercel.json                 # Vercel deployment
├── 📄 deploy.sh                   # Deployment script
├── 📄 setup.sh                    # Setup script
├── 📄 .env.example                # Environment template
├── 📄 package.json                # Dependencies
├── 📄 next.config.ts              # Next.js configuration
├── 📄 tailwind.config.js          # Tailwind CSS configuration
├── 📄 tsconfig.json               # TypeScript configuration
└── 📄 README.md                   # Documentation
```

---

## 🚀 Deployment

### Vercel (Khuyến nghị)
[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/your-username/ios-device-info-tool)

```bash
# Tự động deploy
./deploy.sh
# Chọn option 1 (Vercel)
```

### Docker
```bash
# Build và chạy với Docker
docker-compose up -d
```

### VPS/Server
```bash
# Deploy lên VPS
./deploy.sh
# Chọn option 4 (VPS/Server)
```

### Netlify
```bash
# Build và deploy
npm run build
npm run export
# Upload folder 'out' lên Netlify
```

---

## 🔧 API Reference

### Endpoints

#### `GET /api/udid`
Tạo và tải iOS Configuration Profile
- **Response**: File `.mobileconfig`
- **Headers**: `application/x-apple-aspen-config`

#### `GET|POST /api/device-info`
Nhận thông tin thiết bị từ iOS
- **Parameters**: Device information
- **Response**: HTML redirect page

#### `GET /api/health`
Health check endpoint
- **Response**: JSON với trạng thái hệ thống

### Configuration Profile Structure
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>PayloadContent</key>
    <array>
        <dict>
            <key>PayloadType</key>
            <string>Profile Service</string>
            <key>URL</key>
            <string>https://yourdomain.com/api/device-info</string>
            <key>DeviceAttributes</key>
            <array>
                <string>UDID</string>
                <string>SerialNumber</string>
                <!-- More attributes... -->
            </array>
        </dict>
    </array>
</dict>
</plist>
```

---

## 🔒 Bảo mật

### Mã hóa dữ liệu
```typescript
// Telegram credentials được mã hóa
const encryptedToken = configManager.encryptSensitiveData(botToken)
```

### Rate Limiting
```nginx
# Nginx configuration
limit_req_zone $binary_remote_addr zone=api:10m rate=10r/m;
limit_req_zone $binary_remote_addr zone=download:10m rate=5r/m;
```

### Security Headers
```typescript
headers.set('X-Content-Type-Options', 'nosniff')
headers.set('X-Frame-Options', 'SAMEORIGIN')
headers.set('X-XSS-Protection', '1; mode=block')
```

---

## 📊 Monitoring

### Health Check
```bash
curl https://yourdomain.com/api/health
```

### Logs
```bash
# Xem logs realtime
tail -f logs/app-$(date +%Y-%m-%d).log

# Xem logs trong Docker
docker-compose logs -f ios-device-info
```

### Metrics
- Số lượng profile được tải
- Số lượng thiết bị thành công
- Loại thiết bị phổ biến
- Tỷ lệ lỗi

---

## 🛠️ Development

### Cài đặt development
```bash
git clone https://github.com/your-username/ios-device-info-tool.git
cd ios-device-info-tool
npm install
npm run dev
```

### Scripts có sẵn
```bash
npm run dev          # Chạy development server
npm run build        # Build cho production
npm run start        # Chạy production server
npm run lint         # Kiểm tra code style
npm run type-check   # Kiểm tra TypeScript
```

### Testing
```bash
# Test Telegram connection
npm run test:telegram

# Test configuration profile
npm run test:profile

# Test full flow
npm run test:e2e
```

---

## 🤝 Đóng góp

Chúng tôi hoan nghênh mọi đóng góp! Vui lòng đọc [CONTRIBUTING.md](CONTRIBUTING.md) để biết thêm chi tiết.

### Quy trình đóng góp
1. **Fork** repository
2. **Tạo** feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to branch (`git push origin feature/AmazingFeature`)
5. **Tạo** Pull Request

### Code Style
- Sử dụng **TypeScript** cho type safety
- Follow **ESLint** rules
- Sử dụng **Prettier** cho formatting
- Viết **JSDoc** cho functions

---

## 📄 License

Dự án này được phân phối dưới giấy phép MIT. Xem file [LICENSE](LICENSE) để biết thêm chi tiết.

---

## 🙏 Acknowledgments

- [Next.js](https://nextjs.org/) - React framework
- [Tailwind CSS](https://tailwindcss.com/) - CSS framework
- [TypeScript](https://www.typescriptlang.org/) - Type safety
- [Vercel](https://vercel.com/) - Deployment platform

---

## 📞 Hỗ trợ

- 📧 **Email**: contact@example.com
- 💬 **Telegram**: [@your_username](https://t.me/your_username)
- 🐛 **Issues**: [GitHub Issues](https://github.com/your-username/ios-device-info-tool/issues)
- 📖 **Wiki**: [GitHub Wiki](https://github.com/your-username/ios-device-info-tool/wiki)

---

## 🔄 Changelog

### v1.0.0 (2024-01-01)
- ✅ Phiên bản đầu tiên
- ✅ Hỗ trợ lấy UDID và thông tin thiết bị
- ✅ Telegram notifications
- ✅ Giao diện responsive
- ✅ Auto redirect sau cài đặt

### v1.1.0 (Planned)
- 🔄 Rate limiting
- 🔄 Analytics dashboard  
- 🔄 Multi-language support
- 🔄 Dark mode
- 🔄 Batch processing

---

<div align="center">

**⭐ Nếu dự án này hữu ích, hãy cho chúng tôi một star! ⭐**

Made with ❤️ by [Your Name](https://github.com/your-username)

</div>
