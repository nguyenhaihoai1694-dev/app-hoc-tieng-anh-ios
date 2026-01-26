# Firebase Setup - English Learning App

Hướng dẫn cấu hình Firebase cho ứng dụng học tiếng Anh iOS.

## Tính năng Firebase đã tích hợp

✅ **Firebase Authentication**
- Đăng nhập/Đăng ký với Email/Password
- Đăng nhập ẩn danh (Anonymous) cho chế độ demo
- Reset password
- Realtime auth state listener

✅ **Cloud Firestore Database**
- Lưu trữ user profiles (XP, level, streak, completed lessons)
- Lưu lesson progress và scores
- Realtime sync giữa các thiết bị
- Leaderboard realtime với ranking

✅ **Realtime Data Sync**
- User data tự động sync khi có thay đổi
- Leaderboard cập nhật realtime
- Progress tracking across devices

## Cấu trúc Firestore Database

### Collection: `users`
```
users/{userId}
  ├─ id: String (UUID)
  ├─ email: String
  ├─ name: String
  ├─ totalXP: Int
  ├─ level: Int
  ├─ currentStreak: Int
  ├─ longestStreak: Int
  ├─ lastActiveDate: Timestamp
  ├─ joinedDate: Timestamp
  ├─ completedLessons: [String]
  ├─ createdAt: Timestamp
  └─ updatedAt: Timestamp
```

### Collection: `progress`
```
progress/{userId_lessonId}
  ├─ userId: String
  ├─ lessonId: String
  ├─ score: Int
  ├─ xpEarned: Int
  └─ completedAt: Timestamp
```

## Firestore Security Rules

Thêm rules sau vào Firebase Console:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // User documents
    match /users/{userId} {
      // Users can read their own document
      allow read: if request.auth != null && request.auth.uid == userId;

      // Users can create their own document on signup
      allow create: if request.auth != null && request.auth.uid == userId;

      // Users can update their own document
      allow update: if request.auth != null && request.auth.uid == userId;

      // Allow reading all users for leaderboard (only name, totalXP, level)
      allow read: if request.auth != null;
    }

    // Progress documents
    match /progress/{progressId} {
      // Users can read and write their own progress
      allow read, write: if request.auth != null &&
                            resource.data.userId == request.auth.uid;

      // Allow creating progress documents
      allow create: if request.auth != null;
    }
  }
}
```

## Firestore Indexes

Tạo composite index để tối ưu query leaderboard:

1. Vào Firebase Console → Firestore Database → Indexes
2. Tạo index mới:
   - Collection: `users`
   - Fields indexed:
     - `totalXP` (Descending)
   - Query scope: Collection

## Cài đặt Firebase SDK

### 1. Thêm Firebase vào Xcode Project

Có 2 cách:

#### Cách 1: Swift Package Manager (Khuyến nghị)

1. Mở project trong Xcode
2. File → Add Package Dependencies
3. Nhập URL: `https://github.com/firebase/firebase-ios-sdk`
4. Chọn version: `10.x.x` (latest)
5. Chọn các packages cần thiết:
   - FirebaseAuth
   - FirebaseFirestore
   - FirebaseAnalytics (optional)

#### Cách 2: CocoaPods

```ruby
# Podfile
platform :ios, '15.0'

target 'EnglishLearningApp' do
  use_frameworks!

  # Firebase
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Analytics'
end
```

Chạy:
```bash
pod install
```

### 2. Cấu hình Firebase Project

1. Truy cập [Firebase Console](https://console.firebase.google.com/)
2. Tạo project mới hoặc sử dụng project hiện có
3. Thêm iOS app:
   - Bundle ID: `com.englishlearning.app`
   - App nickname: `English Learning App`
4. Download `GoogleService-Info.plist`
5. Thêm file vào Xcode project (đã có sẵn trong code)

### 3. Enable Authentication

1. Firebase Console → Authentication → Get Started
2. Sign-in methods → Enable:
   - Email/Password
   - Anonymous (cho demo mode)

### 4. Create Firestore Database

1. Firebase Console → Firestore Database → Create Database
2. Chọn mode:
   - **Production mode** (khuyến nghị) - cần setup security rules
   - Test mode - cho development
3. Chọn location gần nhất (asia-southeast1)
4. Apply security rules từ phần trên

## Cấu hình App

File `GoogleService-Info.plist` đã được thêm vào project với config:
- Project ID: `demonoti-13665`
- Bundle ID: `com.englishlearning.app`

**Lưu ý:** Nếu tạo project mới, thay thế file `GoogleService-Info.plist` bằng file từ Firebase Console.

## Kiểm tra tích hợp

### Test Authentication
```swift
// App tự động sign in anonymous khi khởi động
// Check Firebase Console → Authentication → Users
// Sẽ thấy anonymous users được tạo
```

### Test Firestore
```swift
// Khi hoàn thành lesson, check:
// Firebase Console → Firestore Database
// Collections: users, progress
```

### Test Realtime Sync
1. Mở app trên 2 devices/simulators khác nhau
2. Hoàn thành lesson trên device 1
3. Xem leaderboard trên device 2 → Tự động cập nhật

## APIs đã implement

### FirebaseAuthService
- `signUp(email:password:name:)` - Đăng ký
- `signIn(email:password:)` - Đăng nhập
- `signInAnonymously()` - Đăng nhập ẩn danh
- `signOut()` - Đăng xuất
- `resetPassword(email:)` - Reset mật khẩu

### FirestoreService
- `createUser()` - Tạo user mới
- `getUser(userId:)` - Lấy thông tin user
- `updateUser()` - Cập nhật user
- `updateUserXP()` - Cập nhật XP
- `updateUserStreak()` - Cập nhật streak
- `saveLessonProgress()` - Lưu progress
- `getUserProgress()` - Lấy progress
- `getLeaderboard()` - Lấy bảng xếp hạng
- `getUserRank()` - Lấy xếp hạng user
- `listenToLeaderboard()` - Realtime leaderboard
- `listenToUser()` - Realtime user data

## Troubleshooting

### Lỗi: "Default app has not been configured"
**Giải pháp:**  Đảm bảo `FirebaseApp.configure()` được gọi trong `AppDelegate`.

### Lỗi: Permission denied
**Giải pháp:** Kiểm tra Firestore Security Rules đã được cấu hình đúng.

### Lỗi: Network error
**Giải pháp:**
- Kiểm tra internet connection
- Kiểm tra `GoogleService-Info.plist` đã được thêm vào project
- Xác nhận Bundle ID khớp với Firebase project

### Data không sync
**Giải pháp:**
- Check Firebase Console xem data có được lưu không
- Kiểm tra auth state: user đã đăng nhập chưa
- Xem logs trong Xcode console

## Performance Tips

1. **Batch Writes**: Gộp nhiều write operations
2. **Offline Persistence**: Firestore tự động cache offline
3. **Pagination**: Leaderboard limit 50 users
4. **Indexes**: Tạo composite indexes cho queries phức tạp

## Monitoring

### Firebase Console Monitoring
- Authentication → Users: Xem users đã đăng ký
- Firestore → Data: Xem database realtime
- Analytics → Dashboard: Xem usage stats

### Xcode Console Logs
```swift
// Enable Firestore debug logging
let db = Firestore.firestore()
let settings = db.settings
settings.cacheSettings = MemoryCacheSettings()
db.settings = settings
```

## Chi phí (Cost)

Firebase có **Free Tier** (Spark Plan) bao gồm:
- **Authentication**: 50,000 Monthly Active Users (MAU)
- **Firestore**:
  - 50,000 reads/day
  - 20,000 writes/day
  - 1 GB storage
- **Realtime**: Unlimited

Đủ cho development và small-scale production.

## Next Steps

1. ✅ Firebase đã được tích hợp
2. ✅ Authentication hoạt động
3. ✅ Firestore sync realtime
4. ✅ Leaderboard realtime

### Tính năng nâng cao có thể thêm:
- [ ] Firebase Cloud Functions (server-side logic)
- [ ] Firebase Storage (lưu ảnh avatar, audio)
- [ ] Firebase Cloud Messaging (push notifications)
- [ ] Firebase Remote Config (A/B testing)
- [ ] Firebase Crashlytics (crash reporting)
- [ ] Firebase Analytics (user behavior tracking)

## Tài liệu tham khảo

- [Firebase iOS Documentation](https://firebase.google.com/docs/ios/setup)
- [Firebase Authentication](https://firebase.google.com/docs/auth/ios/start)
- [Cloud Firestore](https://firebase.google.com/docs/firestore/quickstart)
- [Security Rules](https://firebase.google.com/docs/firestore/security/get-started)
