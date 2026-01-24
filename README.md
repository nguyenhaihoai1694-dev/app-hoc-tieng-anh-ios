# English Learning App - iOS

Ứng dụng học tiếng Anh trên iOS, tương tự Duolingo, được xây dựng bằng SwiftUI.

## Tính năng chính

### 🎓 Học tập
- **Bài học đa dạng**: Từ cơ bản đến nâng cao
- **Nhiều dạng câu hỏi**: Multiple choice, Fill in the blank, Translation, Listening, Speaking
- **Hệ thống cấp độ**: Level up khi đạt đủ XP
- **Streak tracking**: Duy trì chuỗi ngày học liên tiếp

### 💎 Premium Features
- **Không giới hạn bài học**: Truy cập toàn bộ nội dung
- **Không quảng cáo**: Trải nghiệm học tập mượt mà
- **Luyện phát âm AI**: Cải thiện phát âm với công nghệ AI
- **Tải offline**: Học mọi lúc mọi nơi
- **Chứng chỉ**: Nhận chứng chỉ khi hoàn thành khóa học

### 💳 Thanh toán
- **Gói tháng**: $9.99/tháng
- **Gói năm**: $79.99/năm (tiết kiệm 33%)
- **Tích hợp StoreKit**: Thanh toán an toàn qua Apple In-App Purchase
- **Hỗ trợ Visa/Mastercard**: Qua Apple Pay

### 📊 Theo dõi tiến độ
- **XP System**: Tích lũy điểm kinh nghiệm
- **Leaderboard**: Cạnh tranh với bạn bè
- **Statistics**: Theo dõi quá trình học tập
- **Achievements**: Huy hiệu và thành tích

## Cấu trúc dự án

```
EnglishLearningApp/
├── Models/
│   ├── User.swift              # User model với XP, streak, level
│   ├── Lesson.swift            # Lesson và Question models
│   └── Subscription.swift      # Subscription plans và status
├── Views/
│   ├── WelcomeView.swift       # Màn hình chào mừng
│   ├── LoginView.swift         # Đăng nhập
│   ├── RegisterView.swift      # Đăng ký
│   ├── MainTabView.swift       # Tab bar chính
│   ├── HomeView.swift          # Danh sách bài học
│   ├── LessonView.swift        # Quiz/bài tập
│   ├── PaywallView.swift       # Màn hình mua Premium
│   ├── ProfileView.swift       # Hồ sơ người dùng
│   └── LeaderboardView.swift   # Bảng xếp hạng
├── ViewModels/
│   ├── AuthViewModel.swift     # Quản lý authentication
│   └── UserProgressManager.swift # Quản lý tiến độ học tập
├── Services/
│   ├── SubscriptionManager.swift # Quản lý thanh toán StoreKit
│   └── LessonDataService.swift   # Dữ liệu bài học
└── Info.plist
```

## Yêu cầu hệ thống

- iOS 15.0+
- Xcode 15.0+
- Swift 5.9+

## Cài đặt

1. Clone repository:
```bash
git clone https://github.com/nguyenhaihoai1694-dev/app-hoc-tieng-anh-ios.git
```

2. Mở project trong Xcode:
```bash
cd app-hoc-tieng-anh-ios/EnglishLearningApp
open EnglishLearningApp.xcodeproj
```

3. Chạy trên simulator hoặc device

## Cấu hình In-App Purchase

Để kích hoạt tính năng thanh toán:

1. Đăng nhập App Store Connect
2. Tạo In-App Purchase với các product IDs:
   - `com.englishlearning.premium.monthly` - Gói tháng
   - `com.englishlearning.premium.yearly` - Gói năm
3. Cấu hình pricing và metadata
4. Submit để review

## Bài học mẫu

App hiện có 10 bài học mẫu:

**Miễn phí:**
- Chào hỏi cơ bản
- Giới thiệu bản thân
- Số đếm 1-20
- Màu sắc

**Premium:**
- Thì hiện tại đơn
- Gia đình
- Thì hiện tại tiếp diễn
- Thức ăn và đồ uống
- Hỏi đường

## Roadmap

- [ ] Tích hợp backend API
- [ ] Thêm bài học mới
- [ ] Tính năng Speaking với Speech Recognition
- [ ] Social features (bạn bè, chia sẻ)
- [ ] Gamification nâng cao
- [ ] Dark mode
- [ ] Localization (tiếng Việt, tiếng Anh)

## License

MIT License - xem file LICENSE để biết thêm chi tiết

## Liên hệ

Nếu có câu hỏi hoặc góp ý, vui lòng tạo issue trên GitHub.
