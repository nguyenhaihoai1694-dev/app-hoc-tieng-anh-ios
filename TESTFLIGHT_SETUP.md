# TestFlight Setup Guide - English Learning App

## 📋 Tổng quan

Hướng dẫn này giúp bạn setup và test In-App Purchase (IAP) trên TestFlight.

---

## 🔧 Bước 1: Cấu hình App Store Connect

### 1.1. Tạo App trên App Store Connect

1. Truy cập https://appstoreconnect.apple.com
2. Vào **My Apps** → **+** → **New App**
3. Điền thông tin:
   - **Platform**: iOS
   - **Name**: English Learning App for Kids
   - **Primary Language**: English (U.S.)
   - **Bundle ID**: `com.hoai.englishkidsapp` (phải trùng với Xcode)
   - **SKU**: `englishkidsapp001`
   - **User Access**: Full Access

### 1.2. Tạo In-App Purchases

#### Bước 1: Tạo Subscription Group
1. Vào **App** → **Subscriptions** → **+** (Create Subscription Group)
2. **Reference Name**: Premium Subscriptions
3. **App Name**: Premium (hiển thị cho user)

#### Bước 2: Tạo các Subscription Products

Tạo **6 Auto-Renewable Subscriptions** với Product ID sau:

| Product ID | Tên | Giá (USD) | Duration |
|-----------|-----|-----------|----------|
| `com.hoai.englishkidsapp.week1` | 1 Week Premium | $0.99 | 1 week |
| `com.hoai.englishkidsapp.month1` | 1 Month Premium | $2.99 | 1 month |
| `com.hoai.englishkidsapp.month2` | 2 Months Premium | $4.99 | 2 months |
| `com.hoai.englishkidsapp.month3` | 3 Months Premium | $9.99 | 3 months |
| `com.hoai.englishkidsapp.month6` | 6 Months Premium | $19.99 | 6 months |
| `com.hoai.englishkidsapp.year1` | 1 Year Premium | $49.99 | 1 year |

**Chi tiết cho mỗi subscription:**

1. Click **+** trong Subscription Group
2. Select **Auto-Renewable Subscription**
3. Điền thông tin:
   - **Reference Name**: (tên như table)
   - **Product ID**: (ID như table)
   - **Subscription Duration**: (duration như table)
   - **Subscription Prices**: Chọn price tier tương ứng

4. Thêm **Localizations** (2 ngôn ngữ):

   **English (U.S.):**
   - Display Name: (tên như table)
   - Description: Chi tiết về gói (vd: "Try Premium for 1 week. Unlimited hearts, all premium lessons, no ads.")

   **Vietnamese:**
   - Display Name: (vd: "Premium 1 Tuần")
   - Description: Mô tả tiếng Việt

5. Nhấn **Save**

#### Bước 3: Tạo Non-Renewable Subscription (Lifetime)

1. Vào **In-App Purchases** (ở sidebar, không phải trong Subscription Group)
2. Click **+** → **Non-Renewable Subscription**
3. Điền:
   - **Reference Name**: Lifetime Premium
   - **Product ID**: `com.hoai.englishkidsapp.lifetime`
   - **Price**: $99.00 (tier 99)

4. Thêm Localizations:
   - **English**: "Lifetime Premium" / "Unlock all premium features forever. One-time payment, lifetime access!"
   - **Vietnamese**: "Premium Trọn Đời" / "Mở khóa tất cả tính năng Premium mãi mãi. Trả 1 lần, dùng suốt đời!"

5. Nhấn **Save** và **Submit for Review** (để test trên TestFlight)

---

## 🏗️ Bước 2: Cấu hình Xcode

### 2.1. Kiểm tra Bundle Identifier

1. Mở Xcode project
2. Chọn **EnglishLearningApp** target
3. Tab **Signing & Capabilities**
4. Kiểm tra **Bundle Identifier** = `com.hoai.englishkidsapp`

### 2.2. Thêm In-App Purchase Capability

1. Tab **Signing & Capabilities**
2. Click **+ Capability**
3. Tìm và thêm **In-App Purchase**
4. File `EnglishLearningApp.entitlements` đã được update tự động

### 2.3. Enable StoreKit Configuration (cho local testing)

1. **Product** → **Scheme** → **Edit Scheme**
2. Tab **Run** → **Options**
3. **StoreKit Configuration**: Chọn `Configuration.storekit`

---

## 📱 Bước 3: Build và Upload lên TestFlight

### 3.1. Archive Build

1. Chọn device: **Any iOS Device (arm64)**
2. **Product** → **Archive**
3. Đợi build xong (5-10 phút)

### 3.2. Upload lên App Store Connect

1. Window **Organizer** sẽ mở
2. Chọn archive vừa build
3. Click **Distribute App**
4. Chọn **App Store Connect**
5. Click **Upload**
6. Đợi validation và upload (10-20 phút)

### 3.3. Kiểm tra trên App Store Connect

1. Vào https://appstoreconnect.apple.com
2. **My Apps** → **English Learning App**
3. Tab **TestFlight**
4. Đợi "Processing" → "Ready to Test" (30-60 phút)

---

## 👥 Bước 4: Thêm Internal Testers

### 4.1. Tạo Internal Testing Group

1. Trong **TestFlight** tab
2. Sidebar: **Internal Testing** → **+** (tạo group)
3. **Group Name**: Internal Team
4. **Add Testers**: Thêm email (phải là Apple ID)

### 4.2. Enable Build cho Testers

1. Chọn group **Internal Team**
2. Click **+** bên cạnh "Builds"
3. Chọn build vừa upload
4. Testers sẽ nhận email invite

---

## 🧪 Bước 5: Test In-App Purchase trên TestFlight

### 5.1. Tạo Sandbox Tester Account

1. App Store Connect → **Users and Access**
2. Tab **Sandbox Testers**
3. Click **+**
4. Điền thông tin:
   - **First Name**: Test
   - **Last Name**: User
   - **Email**: test+sandbox@yourdomain.com (email ảo, không cần tồn tại)
   - **Password**: Test@123456
   - **Country/Region**: Vietnam
   - **App Store Territory**: Vietnam

5. Click **Save**

### 5.2. Cài đặt TestFlight App

1. Tải **TestFlight** từ App Store
2. Đăng nhập bằng Apple ID (email được mời)
3. Accept invitation
4. Install app **English Learning App**

### 5.3. Test Purchase Flow

**QUAN TRỌNG:**

1. **Settings** → **App Store** → **Sandbox Account**
2. Đăng xuất tất cả accounts
3. Đăng nhập bằng **Sandbox Tester** account (test+sandbox@...)

**Test các bước:**

1. Mở app English Learning App từ TestFlight
2. Vào **Profile** → Nhấn **Upgrade to Premium**
3. Chọn gói subscription (vd: 1 Week Premium)
4. Nhấn **Subscribe**
5. Popup "Confirm Your In-App Purchase" → **Confirm**
6. Nhấn **OK**
7. **Sandbox Environment** banner sẽ hiện (chứng tỏ đang test)
8. Kiểm tra app hiển thị **Premium badge**

**Test Restore Purchases:**

1. Xóa và cài lại app
2. Vào **Profile** → Nhấn nút restore (nếu có)
3. Hoặc thử mua lại → Popup "You're already subscribed"

---

## ✅ Checklist trước khi Submit Production

- [ ] Tất cả IAP products ở trạng thái **Ready to Submit**
- [ ] Test thành công ít nhất 3 subscription plans
- [ ] Test restore purchases
- [ ] Test lifetime purchase
- [ ] Screenshots và description đã chuẩn bị
- [ ] Privacy Policy URL đã thêm
- [ ] App Review Information đã điền đầy đủ

---

## 🐛 Troubleshooting

### Lỗi "Cannot connect to App Store"

- Kiểm tra Bundle ID trùng khớp
- Đảm bảo đã thêm In-App Purchase capability
- Restart Xcode và rebuild

### Lỗi "Product IDs not found"

- Đợi 2-3 giờ sau khi tạo products trên App Store Connect
- Product phải ở trạng thái **Ready to Submit** hoặc **Approved**
- Kiểm tra Product IDs spelling

### Sandbox purchase không work

- Đảm bảo đăng nhập Sandbox account trong **Settings → App Store**
- Đăng xuất Apple ID thật
- Xóa app và reinstall từ TestFlight

### TestFlight build "Processing" quá lâu

- Bình thường: 30-60 phút
- Có thể lên đến 24 giờ trong giờ cao điểm
- Nếu > 48h, contact Apple Support

---

## 📞 Liên hệ hỗ trợ

- Apple Developer Support: https://developer.apple.com/contact/
- StoreKit Documentation: https://developer.apple.com/storekit/

---

## 📝 Notes

**Current Build Info:**
- Version: 1.0.0
- Build: 2
- Bundle ID: com.hoai.englishkidsapp

**Product IDs trong app (7 total):**
```swift
enum ProductID: String {
    case week1 = "com.hoai.englishkidsapp.week1"
    case month1 = "com.hoai.englishkidsapp.month1"
    case month2 = "com.hoai.englishkidsapp.month2"
    case month3 = "com.hoai.englishkidsapp.month3"
    case month6 = "com.hoai.englishkidsapp.month6"
    case year1 = "com.hoai.englishkidsapp.year1"
    case lifetime = "com.hoai.englishkidsapp.lifetime"  // $99
}
```

**Quan trọng**: Các Product IDs này phải **TRÙNG KHỚP 100%** với App Store Connect!
