# iOS Device Info Tool

Công cụ chuyên nghiệp để lấy thông tin chi tiết thiết bị iPhone và iPad thông qua iOS Configuration Profile.

## 🚀 Tính năng

- ✅ Lấy UDID (Unique Device Identifier)
- ✅ Thu thập thông tin chi tiết thiết bị (Serial Number, IMEI, Model, iOS Version, v.v.)
- ✅ Giao diện đẹp mắt, responsive
- ✅ Thông báo Telegram tự động cho admin
- ✅ Bảo mật cao với mã hóa thông tin nhạy cảm
- ✅ Hỗ trợ cả Next.js và HTML thuần
- ✅ Dễ dàng deploy lên hosting

## 📋 Yêu cầu hệ thống

- Node.js 18+ 
- npm hoặc yarn
- Telegram Bot Token (tùy chọn)

## 🛠️ Cài đặt

### 1. Clone repository

```bash
git clone <repository-url>
cd ios-device-info
```

### 2. Cài đặt dependencies

```bash
npm install
# hoặc
yarn install
```

### 3. Cấu hình môi trường

Sao chép file `.env.example` thành `.env.local`:

```bash
cp .env.example .env.local
```

Chỉnh sửa file `.env.local`:

```env
# Telegram Bot Configuration
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
TELEGRAM_ADMIN_ID=your_admin_chat_id_here

# Encryption Key (tạo chuỗi ngẫu nhiên 32 ký tự)
ENCRYPTION_KEY=your_32_character_encryption_key_here

# Next.js Configuration
NEXT_PUBLIC_APP_URL=https://yourdomain.com
```

### 4. Chạy ứng dụng

#### Development mode:
```bash
npm run dev
# hoặc
yarn dev
```

#### Production mode:
```bash
npm run build
npm start
# hoặc
yarn build
yarn start
```

## 🔧 Cấu hình Telegram Bot

### 1. Tạo Telegram Bot

1. Mở Telegram và tìm `@BotFather`
2. Gửi lệnh `/newbot`
3. Đặt tên cho bot
4. Lấy Bot Token

### 2. Lấy Chat ID

1. Gửi tin nhắn cho bot của bạn
2. Truy cập: `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`
3. Tìm `chat.id` trong response

### 3. Test kết nối

```bash
# Trong terminal của dự án
node -e "
const { testTelegramConnection } = require('./src/lib/telegram.ts');
testTelegramConnection().then(result => console.log('Test result:', result));
"
```

## 📱 Cách sử dụng

### Cho người dùng cuối:

1. Truy cập website
2. Nhấn "Tải cấu hình ngay"
3. Cài đặt profile trên thiết bị iOS:
   - Settings → General → VPN & Device Management
   - Chọn profile vừa tải → Install
4. Xem kết quả trên website

### Cho admin:

- Nhận thông báo tự động qua Telegram khi có người dùng mới
- Theo dõi thống kê qua console logs

## 🏗️ Cấu trúc dự án

```
├── src/
│   ├── app/                    # Next.js App Router
│   │   ├── api/
│   │   │   ├── device-info/    # API xử lý thông tin thiết bị
│   │   │   └── udid/           # API tạo configuration profile
│   │   ├── udid/               # Trang tải cấu hình
│   │   └── udid/result/        # Trang hiển thị kết quả
│   ├── lib/
│   │   ├── config.ts           # Quản lý cấu hình bảo mật
│   │   ├── telegram.ts         # Telegram integration
│   │   └── utils.ts            # Utilities
│   └── components/             # React components
├── public/                     # Static files
├── index.html                  # HTML thuần (standalone)
├── result.html                 # Trang kết quả HTML thuần
└── README.md
```

## 🔒 Bảo mật

- ✅ Mã hóa Telegram Bot Token và Admin ID
- ✅ Validation đầu vào
- ✅ Rate limiting (có thể thêm)
- ✅ HTTPS required cho production
- ✅ Không lưu trữ dữ liệu người dùng

## 🚀 Deploy

### Vercel (Khuyến nghị)

1. Push code lên GitHub
2. Kết nối với Vercel
3. Thêm environment variables
4. Deploy

### Netlify

1. Build project: `npm run build`
2. Upload folder `out/` lên Netlify
3. Cấu hình redirects nếu cần

### VPS/Server

```bash
# Build project
npm run build

# Chạy với PM2
pm2 start npm --name "ios-device-info" -- start

# Hoặc với Docker
docker build -t ios-device-info .
docker run -p 3000:3000 ios-device-info
```

## 📊 Monitoring & Analytics

### Logs

- Server logs: `/var/log/` hoặc console
- Telegram notifications: Tự động gửi cho admin
- Error tracking: Console.error

### Metrics có thể theo dõi

- Số lượng profile được tải
- Số lượng thiết bị thành công
- Loại thiết bị phổ biến
- Lỗi xảy ra

## 🔧 Tùy chỉnh

### Thay đổi giao diện

- Chỉnh sửa CSS trong các component
- Thay đổi màu sắc trong Tailwind config
- Tùy chỉnh font trong `layout.tsx`

### Thêm thông tin thiết bị

1. Thêm field vào `DeviceAttributes` trong `src/app/api/udid/route.ts`
2. Cập nhật interface `DeviceInfo` trong `src/lib/telegram.ts`
3. Thêm translation trong `result.html`

### Tùy chỉnh thông báo Telegram

Chỉnh sửa function `formatDeviceInfoMessage` trong `src/lib/telegram.ts`

## ❓ Troubleshooting

### Lỗi thường gặp

1. **Profile không tải được**
   - Kiểm tra HTTPS
   - Kiểm tra CORS headers
   - Kiểm tra định dạng .mobileconfig

2. **Không nhận được thông báo Telegram**
   - Kiểm tra Bot Token
   - Kiểm tra Chat ID
   - Kiểm tra network connectivity

3. **Lỗi build**
   - Xóa `.next` folder
   - Chạy `npm install` lại
   - Kiểm tra Node.js version

### Debug mode

```bash
# Bật debug logs
DEBUG=* npm run dev

# Hoặc chỉ Telegram logs
DEBUG=telegram:* npm run dev
```

## 📄 License

MIT License - Xem file LICENSE để biết thêm chi tiết.

## 🤝 Contributing

1. Fork repository
2. Tạo feature branch
3. Commit changes
4. Push to branch
5. Tạo Pull Request

## 📞 Hỗ trợ

- GitHub Issues: [Link to issues]
- Email: your-email@domain.com
- Telegram: @your_username

## 🔄 Changelog

### v1.0.0
- ✅ Phiên bản đầu tiên
- ✅ Hỗ trợ lấy UDID và thông tin thiết bị
- ✅ Telegram notifications
- ✅ Giao diện responsive

### v1.1.0 (Planned)
- 🔄 Rate limiting
- 🔄 Analytics dashboard
- 🔄 Multi-language support
- 🔄 Dark mode
