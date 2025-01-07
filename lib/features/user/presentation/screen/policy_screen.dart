import 'package:flutter/material.dart';
import 'package:vie_flix/common/widget/scroll_colum_padding_widget.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Policy"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
      ),
      body: ScrollColumPaddingWidget(
        children: [
          _buildSession(
            title: "Mục đích sử dụng",
            icon: Icons.lightbulb,
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text:
                        "Ứng dụng VieFlix được phát triển với mục tiêu cung cấp một nền tảng học tập và nghiên cứu về điện ảnh cho cộng đồng. ",
                  ),
                  TextSpan(
                    text: "VieFlix",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        " tập trung vào việc cung cấp các tài liệu tham khảo, phân tích và đánh giá về các tác phẩm điện ảnh.",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildSession(
            title: "Nguồn dữ liệu và bản quyền",
            icon: Icons.library_books,
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text:
                        "Ứng dụng sử dụng các nguồn dữ liệu công khai từ các nền tảng chia sẻ phim trực tuyến như ",
                  ),
                  TextSpan(
                    text: "KKphim",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ", ",
                  ),
                  TextSpan(
                    text: "NguonC",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ", và ",
                  ),
                  TextSpan(
                    text: "Ophim",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        " để xây dựng thư viện phim tham khảo. Tuy nhiên, ứng dụng không lưu trữ bất kỳ nội dung phim nào trên máy chủ của mình.",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildSession(
            title: "Chính sách bảo mật",
            icon: Icons.privacy_tip,
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: "- Lưu trữ dữ liệu cục bộ: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "Tất cả các cài đặt cá nhân, lịch sử tìm kiếm và danh sách yêu thích sẽ được lưu trên thiết bị của bạn.\n",
                  ),
                  TextSpan(
                    text: "- Bảo mật thông tin đăng nhập: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "Thông tin được mã hóa và bảo vệ an toàn.\n",
                  ),
                  TextSpan(
                    text: "- Không chia sẻ thông tin cá nhân: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "Chúng tôi cam kết không chia sẻ thông tin cá nhân với bên thứ ba.\n",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildSession(
            title: "Lưu ý",
            icon: Icons.warning,
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: "Nếu có thắc mắc hay góp ý xin liên hệ với tôi \nFB:",
                  ),
                  TextSpan(
                    text: " Huan.do22222",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // TextSpan(
                  //   text: " mọi góp ý của bạn sẽ rất có ích trong việc p.",
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSession({
    required String title,
    required Widget child,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        ),
      ],
    );
  }
}
