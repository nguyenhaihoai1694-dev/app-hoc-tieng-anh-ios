import SwiftUI

struct TermsOfServiceView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Điều Khoản Dịch Vụ")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)

                    Text("Cập nhật lần cuối: Tháng 1, 2026")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)

                    // Introduction
                    TermsSectionView(
                        title: "1. Chấp Nhận Điều Khoản",
                        content: """
                        Bằng việc sử dụng ứng dụng Học Tiếng Anh cho Trẻ Em, bạn đồng ý với các điều khoản dịch vụ này. \
                        Nếu bạn là phụ huynh hoặc người giám hộ, bạn đồng ý giám sát việc sử dụng ứng dụng của trẻ.

                        Nếu không đồng ý với các điều khoản, vui lòng không sử dụng ứng dụng.
                        """
                    )

                    // User Accounts
                    TermsSectionView(
                        title: "2. Tài Khoản Người Dùng",
                        content: """
                        • Tài khoản phải được tạo và quản lý bởi phụ huynh hoặc người giám hộ
                        • Mỗi tài khoản chỉ dành cho một trẻ sử dụng
                        • Phụ huynh chịu trách nhiệm bảo mật thông tin đăng nhập
                        • Không được chia sẻ tài khoản với người khác
                        • Phải cung cấp thông tin chính xác khi đăng ký
                        """
                    )

                    // Age Requirements
                    TermsSectionView(
                        title: "3. Yêu Cầu Độ Tuổi",
                        content: """
                        • Ứng dụng dành cho trẻ em từ 6-12 tuổi
                        • Trẻ dưới 13 tuổi phải có sự giám sát của phụ huynh
                        • Phụ huynh phải đồng ý với chính sách bảo mật
                        • Phụ huynh có trách nhiệm kiểm soát thời gian sử dụng ứng dụng
                        """
                    )

                    // Subscription Terms
                    TermsSectionView(
                        title: "4. Điều Khoản Đăng Ký Premium",
                        content: """
                        Gói Premium:
                        • Dùng thử miễn phí 7 ngày cho người dùng mới
                        • Tự động gia hạn hàng tháng/năm trừ khi hủy
                        • Hủy bất kỳ lúc nào qua cài đặt App Store
                        • Không hoàn tiền cho thời gian chưa sử dụng
                        • Giá có thể thay đổi với thông báo trước 30 ngày

                        Để hủy đăng ký:
                        1. Mở Cài đặt trên iPhone/iPad
                        2. Chọn tên của bạn → Đăng ký
                        3. Chọn ứng dụng → Hủy đăng ký
                        """
                    )

                    // Acceptable Use
                    TermsSectionView(
                        title: "5. Sử Dụng Chấp Nhận Được",
                        content: """
                        Người dùng ĐƯỢC PHÉP:
                        • Sử dụng ứng dụng cho mục đích học tập cá nhân
                        • Truy cập tất cả nội dung được cung cấp
                        • Báo cáo lỗi hoặc đóng góp ý kiến

                        Người dùng KHÔNG ĐƯỢC:
                        • Sao chép, sửa đổi, hoặc phân phối nội dung ứng dụng
                        • Cố gắng hack hoặc can thiệp vào hệ thống
                        • Sử dụng ứng dụng cho mục đích thương mại
                        • Chia sẻ tài khoản Premium với người khác
                        • Đăng tải nội dung không phù hợp
                        """
                    )

                    // Intellectual Property
                    TermsSectionView(
                        title: "6. Quyền Sở Hữu Trí Tuệ",
                        content: """
                        • Tất cả nội dung, hình ảnh, âm thanh, và mã nguồn thuộc về English Learning App
                        • Các nhãn hiệu và logo được bảo vệ bởi luật sở hữu trí tuệ
                        • Người dùng không có quyền sử dụng tài sản trí tuệ của chúng tôi
                        • Bất kỳ vi phạm nào có thể dẫn đến hành động pháp lý
                        """
                    )

                    // Content and Updates
                    TermsSectionView(
                        title: "7. Nội Dung và Cập Nhật",
                        content: """
                        • Chúng tôi có quyền thay đổi, cập nhật hoặc xóa nội dung bất kỳ lúc nào
                        • Cập nhật ứng dụng có thể được yêu cầu để tiếp tục sử dụng
                        • Nội dung mới có thể được thêm vào định kỳ
                        • Một số tính năng có thể yêu cầu kết nối internet
                        """
                    )

                    // Limitation of Liability
                    TermsSectionView(
                        title: "8. Giới Hạn Trách Nhiệm",
                        content: """
                        • Ứng dụng được cung cấp "như hiện tại"
                        • Chúng tôi không đảm bảo ứng dụng hoạt động liên tục hoặc không có lỗi
                        • Chúng tôi không chịu trách nhiệm về thiệt hại gián tiếp từ việc sử dụng ứng dụng
                        • Trách nhiệm tối đa của chúng tôi giới hạn ở số tiền bạn đã thanh toán
                        """
                    )

                    // Privacy
                    TermsSectionView(
                        title: "9. Quyền Riêng Tư",
                        content: """
                        Việc sử dụng ứng dụng cũng tuân theo Chính Sách Bảo Mật của chúng tôi. \
                        Vui lòng xem lại Chính Sách Bảo Mật để hiểu cách chúng tôi thu thập và sử dụng dữ liệu.

                        Chúng tôi cam kết bảo vệ quyền riêng tư của trẻ em theo COPPA và các luật bảo vệ dữ liệu quốc tế.
                        """
                    )

                    // Account Termination
                    TermsSectionView(
                        title: "10. Chấm Dứt Tài Khoản",
                        content: """
                        Chúng tôi có quyền:
                        • Đình chỉ hoặc xóa tài khoản vi phạm điều khoản
                        • Từ chối dịch vụ cho bất kỳ ai

                        Người dùng có thể:
                        • Xóa tài khoản bất kỳ lúc nào qua cài đặt ứng dụng
                        • Khi xóa tài khoản, tất cả dữ liệu sẽ bị xóa vĩnh viễn
                        """
                    )

                    // Dispute Resolution
                    TermsSectionView(
                        title: "11. Giải Quyết Tranh Chấp",
                        content: """
                        • Mọi tranh chấp sẽ được giải quyết thông qua thương lượng thân thiện
                        • Nếu không giải quyết được, sẽ áp dụng trọng tài
                        • Luật Việt Nam sẽ được áp dụng
                        """
                    )

                    // Changes to Terms
                    TermsSectionView(
                        title: "12. Thay Đổi Điều Khoản",
                        content: """
                        Chúng tôi có thể cập nhật các điều khoản này để phản ánh:
                        • Thay đổi trong tính năng ứng dụng
                        • Yêu cầu pháp lý mới
                        • Cải tiến dịch vụ

                        Người dùng sẽ được thông báo về thay đổi quan trọng. \
                        Việc tiếp tục sử dụng sau khi thay đổi có nghĩa là bạn chấp nhận điều khoản mới.
                        """
                    )

                    // Contact
                    TermsSectionView(
                        title: "13. Liên Hệ",
                        content: """
                        Nếu có câu hỏi về điều khoản dịch vụ:

                        Email: nguyenhaihoai1694@gmail.com
                        Website: https://nguyenhaihoai1694-dev.github.io/app-hoc-tieng-anh-ios/

                        Thời gian phản hồi: Trong vòng 48 giờ
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

struct TermsSectionView: View {
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

struct TermsOfServiceView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView()
    }
}
