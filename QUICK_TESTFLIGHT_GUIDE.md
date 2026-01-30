# Quick TestFlight Guide - IAP Testing

## 🚀 Bước nhanh để upload TestFlight

### 1. Tạo Products trên App Store Connect (CHỈ LÀM 1 LẦN)

**Vào:** https://appstoreconnect.apple.com → My Apps → Your App

**Tạo 7 products với Product IDs SAU (PHẢI ĐÚNG 100%):**

```
com.hoai.englishkidsapp.week1     → $0.99  (1 week)
com.hoai.englishkidsapp.month1    → $2.99  (1 month)
com.hoai.englishkidsapp.month2    → $4.99  (2 months)
com.hoai.englishkidsapp.month3    → $9.99  (3 months)
com.hoai.englishkidsapp.month6    → $19.99 (6 months)
com.hoai.englishkidsapp.year1     → $49.99 (1 year)
com.hoai.englishkidsapp.lifetime  → $99.00 (non-renewable)
```

**Lưu ý:**
- 6 cái đầu: Auto-Renewable Subscription (trong Subscription Group)
- Cái lifetime: Non-Renewable Subscription (ngoài group)
- Nhớ **Submit for Review** mỗi product để test được

---

### 2. Build và Upload

**Trong Xcode:**

```bash
# 1. Chọn target
Any iOS Device (arm64)

# 2. Archive
Product → Archive

# 3. Khi Organizer mở
→ Distribute App
→ App Store Connect
→ Upload
→ Đợi 10-20 phút

# 4. Kiểm tra App Store Connect
→ TestFlight tab
→ Đợi build "Processing" → "Ready to Test" (30-60 phút)
```

---

### 3. Test IAP trên TestFlight

#### A. Tạo Sandbox Tester (LÀM 1 LẦN)

**App Store Connect** → Users and Access → Sandbox Testers → **+**

```
Email: test+sandbox1@youremail.com (email ảo)
Password: Test@123456
Country: Vietnam
```

#### B. Setup iPhone

**iPhone Settings:**
```
Settings → App Store → Sandbox Account
→ Sign Out (nếu có)
→ Sign In: test+sandbox1@youremail.com / Test@123456
```

#### C. Test Flow

1. Mở app từ **TestFlight**
2. Vào Profile → "Upgrade to Premium"
3. Chọn gói → Subscribe
4. Nhấn **Confirm**
5. Thấy **[Environment: Sandbox]** = thành công!

---

## ❗ 3 Lỗi Phổ Biến

### 1. "Cannot Connect to App Store"

**Fix:**
- Đợi 2-3 giờ sau khi tạo products
- Rebuild app
- Kiểm tra internet

### 2. "Product IDs not found"

**Fix:**
- Products phải **Ready to Submit** hoặc **Approved**
- Check spelling Product IDs
- Đợi thêm vài giờ

### 3. Purchase không work

**Fix:**
```
Settings → App Store
→ Đăng xuất Apple ID thật
→ Đăng nhập Sandbox account
→ Xóa app, reinstall từ TestFlight
```

---

## 📦 Thông tin Build hiện tại

```
Bundle ID: com.hoai.englishkidsapp
Version: 1.0.0
Build: 2
```

**Mỗi lần upload mới:**
- Tăng Build number lên (2 → 3 → 4...)
- Version giữ nguyên 1.0.0 (chỉ tăng khi release production)

---

## 🎯 Test Checklist

- [ ] Tạo đủ 7 IAP products trên App Store Connect
- [ ] Submit for Review tất cả products
- [ ] Archive và upload build
- [ ] Build hiển thị "Ready to Test" trong TestFlight
- [ ] Tạo Sandbox tester account
- [ ] Đăng nhập Sandbox trong Settings
- [ ] Mua thành công 1 gói subscription
- [ ] Thấy Premium badge trong app
- [ ] Test restore purchases (xóa app, reinstall, restore)

---

## 💡 Tips

1. **Đợi đủ thời gian:**
   - Sau tạo products: đợi 2-3 giờ
   - Upload build: đợi 30-60 phút processing

2. **Dùng Sandbox account riêng:**
   - KHÔNG dùng Apple ID thật
   - Tạo nhiều sandbox accounts để test

3. **Check logs:**
   - Xcode Console để xem lỗi IAP
   - App Store Connect → Activity để xem build status

4. **TestFlight có giới hạn:**
   - Mỗi build test được 90 ngày
   - Max 10,000 internal testers
   - Max 10,000 external testers

---

**Đọc thêm:** Xem `TESTFLIGHT_SETUP.md` để hiểu chi tiết từng bước.
