# 🤝 Contributing to iOS Device Info Tool

Cảm ơn bạn đã quan tâm đến việc đóng góp cho dự án iOS Device Info Tool! Chúng tôi hoan nghênh mọi đóng góp từ cộng đồng.

## 📋 Mục lục

- [Code of Conduct](#code-of-conduct)
- [Cách đóng góp](#cách-đóng-góp)
- [Quy trình phát triển](#quy-trình-phát-triển)
- [Coding Standards](#coding-standards)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Báo cáo lỗi](#báo-cáo-lỗi)
- [Đề xuất tính năng](#đề-xuất-tính-năng)

## 📜 Code of Conduct

Dự án này tuân thủ [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). Bằng cách tham gia, bạn đồng ý tuân theo các quy tắc này.

## 🚀 Cách đóng góp

### Các cách bạn có thể đóng góp:

1. **🐛 Báo cáo lỗi** - Tìm và báo cáo bugs
2. **💡 Đề xuất tính năng** - Ý tưởng cho tính năng mới
3. **📝 Cải thiện tài liệu** - Sửa lỗi chính tả, thêm ví dụ
4. **💻 Đóng góp code** - Fix bugs, thêm tính năng
5. **🧪 Testing** - Kiểm thử và báo cáo kết quả
6. **🎨 UI/UX** - Cải thiện giao diện người dùng

## 🔄 Quy trình phát triển

### 1. Fork và Clone
```bash
# Fork repository trên GitHub
# Clone fork của bạn
git clone https://github.com/your-username/ios-device-info-tool.git
cd ios-device-info-tool

# Thêm upstream remote
git remote add upstream https://github.com/original-owner/ios-device-info-tool.git
```

### 2. Cài đặt môi trường
```bash
# Cài đặt dependencies
npm install

# Chạy setup script
chmod +x setup.sh
./setup.sh

# Chạy development server
npm run dev
```

### 3. Tạo branch mới
```bash
# Tạo branch từ main
git checkout -b feature/your-feature-name

# Hoặc cho bug fix
git checkout -b fix/bug-description
```

### 4. Phát triển
- Viết code theo coding standards
- Thêm tests nếu cần thiết
- Cập nhật documentation
- Test thoroughly

### 5. Commit và Push
```bash
# Add changes
git add .

# Commit với message rõ ràng
git commit -m "feat: add new device detection feature"

# Push to your fork
git push origin feature/your-feature-name
```

### 6. Tạo Pull Request
- Mở Pull Request từ fork của bạn
- Điền đầy đủ thông tin trong PR template
- Chờ review và feedback

## 📏 Coding Standards

### TypeScript/JavaScript
```typescript
// ✅ Good
interface DeviceInfo {
  udid: string
  serialNumber: string
  model: string
}

const getDeviceInfo = async (deviceId: string): Promise<DeviceInfo> => {
  // Implementation
}

// ❌ Bad
const getDeviceInfo = (deviceId) => {
  // No types, unclear return
}
```

### React Components
```tsx
// ✅ Good
interface Props {
  deviceInfo: DeviceInfo
  onUpdate: (info: DeviceInfo) => void
}

export const DeviceCard: React.FC<Props> = ({ deviceInfo, onUpdate }) => {
  return (
    <div className="device-card">
      {/* Component content */}
    </div>
  )
}

// ❌ Bad
export const DeviceCard = (props) => {
  return <div>{/* No types, unclear props */}</div>
}
```

### CSS/Styling
```css
/* ✅ Good - Use Tailwind classes */
<div className="flex items-center justify-between p-4 bg-white rounded-lg shadow-md">

/* ❌ Bad - Avoid custom CSS unless necessary */
<div style={{display: 'flex', padding: '16px'}}>
```

### File Naming
```
✅ Good:
- components/DeviceCard.tsx
- lib/deviceUtils.ts
- api/device-info/route.ts

❌ Bad:
- components/devicecard.tsx
- lib/device_utils.ts
- api/deviceInfo.ts
```

## 📝 Commit Guidelines

Chúng tôi sử dụng [Conventional Commits](https://www.conventionalcommits.org/):

### Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types
- `feat`: Tính năng mới
- `fix`: Sửa lỗi
- `docs`: Thay đổi documentation
- `style`: Thay đổi formatting, không ảnh hưởng code
- `refactor`: Refactor code
- `test`: Thêm hoặc sửa tests
- `chore`: Thay đổi build process, tools

### Examples
```bash
# Tính năng mới
git commit -m "feat: add device battery level detection"

# Sửa lỗi
git commit -m "fix: resolve UDID parsing issue on iOS 17"

# Documentation
git commit -m "docs: update installation guide"

# Refactor
git commit -m "refactor: simplify device info parsing logic"
```

## 🔍 Pull Request Process

### PR Checklist
- [ ] Code follows project coding standards
- [ ] Self-review completed
- [ ] Tests added/updated if needed
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)
- [ ] PR title follows conventional commits format

### PR Template
```markdown
## 📝 Description
Brief description of changes

## 🔄 Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## 🧪 Testing
- [ ] Tested locally
- [ ] Added/updated tests
- [ ] All tests pass

## 📸 Screenshots (if applicable)
Add screenshots for UI changes

## 📋 Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
```

## 🐛 Báo cáo lỗi

### Trước khi báo cáo
1. Tìm kiếm trong [existing issues](https://github.com/your-username/ios-device-info-tool/issues)
2. Kiểm tra [FAQ](https://github.com/your-username/ios-device-info-tool/wiki/FAQ)
3. Thử với phiên bản mới nhất

### Bug Report Template
```markdown
## 🐛 Bug Description
Clear description of the bug

## 🔄 Steps to Reproduce
1. Go to '...'
2. Click on '...'
3. See error

## 🎯 Expected Behavior
What should happen

## 📱 Environment
- OS: [e.g. iOS 17.1]
- Browser: [e.g. Safari 17]
- Device: [e.g. iPhone 15 Pro]
- App Version: [e.g. 1.0.0]

## 📸 Screenshots
Add screenshots if applicable

## 📋 Additional Context
Any other context about the problem
```

## 💡 Đề xuất tính năng

### Feature Request Template
```markdown
## 🚀 Feature Description
Clear description of the feature

## 🎯 Problem Statement
What problem does this solve?

## 💡 Proposed Solution
How should this feature work?

## 🔄 Alternatives Considered
Other solutions you've considered

## 📋 Additional Context
Any other context, mockups, examples
```

## 🧪 Testing

### Chạy tests
```bash
# Unit tests
npm run test

# E2E tests
npm run test:e2e

# Type checking
npm run type-check

# Linting
npm run lint
```

### Test Guidelines
- Viết tests cho new features
- Maintain test coverage > 80%
- Test edge cases
- Mock external dependencies

## 📚 Documentation

### Cập nhật Documentation
- README.md cho changes lớn
- Code comments cho complex logic
- API documentation cho new endpoints
- Examples cho new features

### Documentation Style
```typescript
/**
 * Retrieves device information from iOS configuration profile
 * @param deviceId - Unique device identifier
 * @param options - Configuration options
 * @returns Promise resolving to device information
 * @throws {Error} When device ID is invalid
 * @example
 * ```typescript
 * const info = await getDeviceInfo('ABC123', { includeNetwork: true })
 * console.log(info.udid)
 * ```
 */
export async function getDeviceInfo(
  deviceId: string,
  options: DeviceOptions = {}
): Promise<DeviceInfo> {
  // Implementation
}
```

## 🏷️ Release Process

### Versioning
Chúng tôi sử dụng [Semantic Versioning](https://semver.org/):
- `MAJOR.MINOR.PATCH`
- MAJOR: Breaking changes
- MINOR: New features (backward compatible)
- PATCH: Bug fixes

### Release Checklist
- [ ] All tests pass
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version bumped
- [ ] Git tag created
- [ ] Release notes written

## 🤔 Cần hỗ trợ?

- 💬 [GitHub Discussions](https://github.com/your-username/ios-device-info-tool/discussions)
- 📧 Email: contact@example.com
- 💬 Telegram: [@your_username](https://t.me/your_username)

## 🙏 Cảm ơn

Cảm ơn tất cả contributors đã đóng góp cho dự án này! 

### Top Contributors
<!-- This will be automatically updated -->
<a href="https://github.com/your-username/ios-device-info-tool/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=your-username/ios-device-info-tool" />
</a>

---

**Happy Contributing! 🎉**
