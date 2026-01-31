import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Chính Sách Bảo Mật")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)

                    Text("Cập nhật lần cuối: Tháng 1, 2026")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)

                    // Introduction
                    SectionView(
                        title: "1. Giới Thiệu",
                        content: """
                        Ứng dụng Học Tiếng Anh cho Trẻ Em được thiết kế đặc biệt để bảo vệ quyền riêng tư của trẻ em. \
                        Chúng tôi tuân thủ nghiêm ngặt các quy định về bảo vệ trẻ em trực tuyến (COPPA) và các luật bảo vệ dữ liệu quốc tế.
                        """
                    )

                    // Data Collection
                    SectionView(
                        title: "2. Thông Tin Chúng Tôi Thu Thập",
                        content: """
                        Đối với trẻ em dưới 13 tuổi, chúng tôi CHỈ thu thập:

                        • Thông tin học tập: Tiến độ bài học, điểm số, thành tích
                        • Thông tin tài khoản: Tên hiển thị (không yêu cầu tên thật)
                        • Dữ liệu thiết bị: Loại thiết bị, hệ điều hành (cho mục đích kỹ thuật)

                        Chúng tôi KHÔNG thu thập:
                        • Thông tin cá nhân nhận dạng (địa chỉ, số điện thoại, email của trẻ)
                        • Vị trí chính xác
                        • Hình ảnh hoặc video của trẻ
                        • Danh bạ hoặc thông tin thiết bị cá nhân khác
                        """
                    )

                    // Data Usage
                    SectionView(
                        title: "3. Cách Chúng Tôi Sử Dụng Dữ Liệu",
                        content: """
                        Dữ liệu được sử dụng để:

                        • Cung cấp và cải thiện trải nghiệm học tập
                        • Theo dõi tiến độ học tập của trẻ
                        • Cá nhân hóa nội dung phù hợp với trình độ
                        • Hiển thị thành tích và phần thưởng
                        • Hỗ trợ kỹ thuật khi cần thiết

                        Chúng tôi KHÔNG bao giờ:
                        • Bán hoặc chia sẻ dữ liệu trẻ em với bên thứ ba
                        • Sử dụng dữ liệu cho quảng cáo nhắm mục tiêu
                        • Hiển thị quảng cáo bên thứ ba trong ứng dụng
                        """
                    )

                    // Parental Rights
                    SectionView(
                        title: "4. Quyền Của Phụ Huynh",
                        content: """
                        Phụ huynh có quyền:

                        • Xem lại dữ liệu của con mình
                        • Yêu cầu xóa dữ liệu bất kỳ lúc nào
                        • Từ chối cho phép thu thập dữ liệu thêm
                        • Liên hệ với chúng tôi về bất kỳ mối quan ngại nào

                        Để thực hiện các quyền này, vui lòng liên hệ: support@englishlearningapp.com
                        """
                    )

                    // Data Security
                    SectionView(
                        title: "5. Bảo Mật Dữ Liệu",
                        content: """
                        Chúng tôi áp dụng các biện pháp bảo mật:

                        • Mã hóa dữ liệu khi truyền tải (SSL/TLS)
                        • Lưu trữ an toàn trên Firebase (Google Cloud)
                        • Kiểm soát truy cập nghiêm ngặt
                        • Đánh giá bảo mật định kỳ
                        • Tuân thủ các tiêu chuẩn bảo mật ngành
                        """
                    )

                    // Third-Party Services
                    SectionView(
                        title: "6. Dịch Vụ Bên Thứ Ba",
                        content: """
                        Chúng tôi sử dụng các dịch vụ sau:

                        • Firebase (Google): Xác thực và lưu trữ dữ liệu
                        • Apple App Store: Xử lý thanh toán gói Premium

                        Các dịch vụ này tuân thủ COPPA và cam kết bảo vệ quyền riêng tư trẻ em.
                        """
                    )

                    // Data Retention
                    SectionView(
                        title: "7. Lưu Trữ Dữ Liệu",
                        content: """
                        • Dữ liệu học tập được lưu trữ miễn là tài khoản còn hoạt động
                        • Khi tài khoản bị xóa, tất cả dữ liệu sẽ bị xóa vĩnh viễn trong 30 ngày
                        • Phụ huynh có thể yêu cầu xóa dữ liệu ngay lập tức bất kỳ lúc nào
                        """
                    )

                    // Contact
                    SectionView(
                        title: "8. Liên Hệ",
                        content: """
                        Nếu có thắc mắc về chính sách bảo mật:

                        Email: nguyenhaihoai1694@gmail.com
                        Website: https://nguyenhaihoai1694-dev.github.io/app-hoc-tieng-anh-ios/

                        Chúng tôi sẽ phản hồi trong vòng 48 giờ.
                        """
                    )

                    // Changes to Policy
                    SectionView(
                        title: "9. Thay Đổi Chính Sách",
                        content: """
                        Chúng tôi có thể cập nhật chính sách này để phản ánh thay đổi trong ứng dụng hoặc yêu cầu pháp lý. \
                        Phụ huynh sẽ được thông báo về các thay đổi quan trọng qua email hoặc thông báo trong ứng dụng.
                        """
                    )

                    Text("© 2026 English Learning App. All rights reserved.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 30)
                }
                .padding()
            }
            .navigationBarItems(trailing: Button("Đóng") {
                dismiss()
            })
        }
    }
}

struct SectionView: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
