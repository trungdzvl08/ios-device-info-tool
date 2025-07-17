# 🚀 Quick Start Guide

## Chạy nhanh với port 8000

### 1. Clone và setup
```bash
git clone https://github.com/your-username/ios-device-info-tool.git
cd ios-device-info-tool
chmod +x setup.sh
./setup.sh
```

### 2. Cấu hình môi trường
Chỉnh sửa `.env.local`:
```env
TELEGRAM_BOT_TOKEN=your_bot_token_here
TELEGRAM_ADMIN_ID=your_admin_id_here
ENCRYPTION_KEY=auto_generated_key
NEXT_PUBLIC_APP_URL=http://localhost:8000
```

### 3. Chạy development server
```bash
npm run dev
```

Truy cập: **http://localhost:8000**

### 4. Deploy với Docker
```bash
docker-compose up -d
```

Truy cập: **http://localhost:8000**

---

## 📱 Cách sử dụng

1. **Truy cập http://localhost:8000**
2. **Nhấn "Tải cấu hình ngay"**
3. **Cài đặt profile trên iOS:**
   - Settings → General → VPN & Device Management
   - Install Profile
4. **Xem kết quả tự động**

---

## 🔧 Troubleshooting

### Port 8000 đã được sử dụng?
```bash
# Kill process trên port 8000
fuser -k 8000/tcp

# Hoặc tìm process
lsof -i :8000
```

### Telegram không hoạt động?
1. Kiểm tra bot token trong `.env.local`
2. Kiểm tra admin chat ID
3. Test connection:
```bash
curl -X GET "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getMe"
```

---

## 🎯 Features

- ✅ **Port 8000** - Giống web demo
- ✅ **Auto redirect** - Tự động chuyển hướng
- ✅ **Telegram notifications** - Thông báo tự động
- ✅ **Beautiful UI** - Giao diện đẹp mắt
- ✅ **Docker ready** - Sẵn sàng deploy

---

**Happy coding! 🎉**
