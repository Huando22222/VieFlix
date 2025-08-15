import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/card_horiziontal_widget.dart';
import 'package:vie_flix/features/user/presentation/controller/app_setting_controller.dart';
import 'package:vie_flix/features/user/presentation/controller/favorite_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController =
        Get.find<FavoriteController>();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surface.withOpacity(0.95),
            theme.colorScheme.background,
          ],
          stops: const [0.0, 0.3, 1.0],
        ),
      ),
      child: Column(
        children: [
          // Custom App Header
          _buildCustomAppBar(context, theme, favoriteController),

          // Content Area
          Expanded(
            child: Obx(() {
              if (favoriteController.favorites.isEmpty) {
                return _buildEmptyState(context, theme, size);
              }

              return _buildFavoritesList(context, favoriteController, theme);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context, ThemeData theme,
      FavoriteController favoriteController) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // App Icon & Title
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.favorite_rounded,
              color: Colors.red,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Yêu thích',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(() => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${favoriteController.favorites.length}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
                  ],
                ),
                Text(
                  'Bộ sưu tập phim của bạn',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          // Sort & Filter Actions
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: IconButton(
                  onPressed: () => _showSortOptions(context, theme),
                  icon: Icon(
                    Icons.sort_rounded,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  tooltip: 'Sắp xếp',
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  tooltip: 'Tùy chọn',
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'clear_all',
                      child: Row(
                        children: [
                          Icon(Icons.clear_all_rounded,
                              size: 20, color: Colors.red),
                          const SizedBox(width: 12),
                          const Text('Xóa tất cả'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'export',
                      child: Row(
                        children: [
                          Icon(Icons.file_download_outlined, size: 20),
                          const SizedBox(width: 12),
                          const Text('Xuất danh sách'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) =>
                      _handleMenuAction(context, value, favoriteController),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(BuildContext context,
      FavoriteController favoriteController, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // List Header with swipe instruction
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.swipe_left_rounded,
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Vuốt sang trái để xem thêm tùy chọn',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Favorites List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final favorite = favoriteController.favorites[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Slidable(
                      key: ValueKey(favorite.slug),
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        extentRatio: 0.5,
                        children: [
                          // Share Action
                          CustomSlidableAction(
                            flex: 1,
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            onPressed: (context) =>
                                _handleShareAction(context, favorite),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:
                                      const Icon(Icons.share_rounded, size: 20),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Chia sẻ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Delete Action
                          CustomSlidableAction(
                            flex: 1,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            onPressed: (context) => _showDeleteConfirmation(
                                context, theme, favoriteController, index),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.delete_rounded, size: 20),
                                const SizedBox(height: 4),
                                const Text(
                                  'Xóa',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CardHorizontalWidget(
                          slug: favorite.slug,
                          name: favorite.name,
                          originName: favorite.originName,
                          source: favorite.source,
                          imagePath: favorite.imagePath,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemCount: favoriteController.favorites.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme, Size size) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty State Illustration
            ElevatedButton.icon(
              onPressed: () {
                final AppSettingController appSettingController =
                    Get.find<AppSettingController>();
                appSettingController.changeShowIntro();
                Get.offAllNamed(AppRoute.onBoardingScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              icon: const Icon(Icons.explore_rounded),
              label: const Text(
                'Khám phá phim',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 16),

            // Tips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tips_and_updates_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Mẹo sử dụng',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nhấn vào icon ❤️ trên bất kỳ bộ phim nào để thêm vào danh sách yêu thích của bạn',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, ThemeData theme,
      FavoriteController favoriteController, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text('Xác nhận xóa'),
            ],
          ),
          content: Text(
            'Bạn có chắc muốn xóa "${favoriteController.favorites[index].name}" khỏi danh sách yêu thích?',
            style: theme.textTheme.bodyMedium,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Hủy',
                style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.7)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                favoriteController
                    .addOrRemoveFavorite(favoriteController.favorites[index]);
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.check_circle_rounded,
                            color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text('Đã xóa khỏi danh sách yêu thích'),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  void _handleShareAction(BuildContext context, dynamic favorite) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.share_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text('Đã chia sẻ "${favorite.name}"')),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showSortOptions(BuildContext context, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.sort_rounded, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Sắp xếp danh sách',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSortOption(context, 'Mới nhất', Icons.schedule_rounded),
              _buildSortOption(context, 'Tên A-Z', Icons.sort_by_alpha_rounded),
              _buildSortOption(context, 'Tên Z-A', Icons.sort_by_alpha_rounded),
              _buildSortOption(context, 'Thể loại', Icons.category_rounded),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, size: 20),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        // Implement sort logic here
      },
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }

  void _handleMenuAction(BuildContext context, String action,
      FavoriteController favoriteController) {
    switch (action) {
      case 'clear_all':
        _showClearAllConfirmation(context, favoriteController);
        break;
      case 'export':
        // Implement export functionality
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Chức năng xuất danh sách đang được phát triển')),
        );
        break;
    }
  }

  void _showClearAllConfirmation(
      BuildContext context, FavoriteController favoriteController) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text('Xóa tất cả'),
          ],
        ),
        content: const Text(
            'Bạn có chắc muốn xóa tất cả phim khỏi danh sách yêu thích?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              // Clear all favorites logic here
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
                const Text('Xóa tất cả', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
