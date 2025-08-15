import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chính sách',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSession(
                context: context,
                title: 'Mục đích sử dụng',
                icon: Icons.lightbulb,
                children: [
                  Text(
                    'Ứng dụng VieFlix được phát triển với mục tiêu cung cấp một nền tảng học tập và nghiên cứu về điện ảnh cho cộng đồng. VieFlix tập trung vào việc cung cấp các tài liệu tham khảo, phân tích và đánh giá về các tác phẩm điện ảnh.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSession(
                context: context,
                title: 'Nguồn dữ liệu và bản quyền',
                icon: Icons.library_books,
                children: [
                  Text(
                    'Ứng dụng sử dụng các nguồn dữ liệu công khai từ các nền tảng chia sẻ phim trực tuyến như KKphim, NguonC, và Ophim để xây dựng thư viện phim tham khảo. Tuy nhiên, ứng dụng không lưu trữ bất kỳ nội dung phim nào trên máy chủ của mình.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSession(
                context: context,
                title: 'Chính sách bảo mật',
                icon: Icons.privacy_tip,
                children: [
                  _buildListItem(
                    context: context,
                    text:
                        'Lưu trữ dữ liệu cục bộ: Tất cả các cài đặt cá nhân, lịch sử tìm kiếm và danh sách yêu thích sẽ được lưu trên thiết bị của bạn.',
                  ),
                  _buildListItem(
                    context: context,
                    text:
                        'Bảo mật thông tin đăng nhập: Thông tin được mã hóa và bảo vệ an toàn.',
                  ),
                  _buildListItem(
                    context: context,
                    text:
                        'Không chia sẻ thông tin cá nhân: Chúng tôi cam kết không chia sẻ thông tin cá nhân với bên thứ ba.',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSession(
                context: context,
                title: 'Lưu ý',
                icon: Icons.warning,
                children: [
                  Text(
                    'Nếu có thắc mắc hoặc góp ý, xin liên hệ qua Gmail: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Huando.work@gmail.com',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSession({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
