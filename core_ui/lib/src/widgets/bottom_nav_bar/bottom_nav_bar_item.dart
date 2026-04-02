part of 'bottom_nav_bar.dart';

class _BottomNavBarItem extends StatelessWidget {
  final bool isActive;
  final bool isEnabled;
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool showNotification;

  const _BottomNavBarItem({
    required this.isActive,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isEnabled = true,
    this.showNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    final Color activeColor = colors.tertiary[500]!;
    final Color inactiveColor = colors.secondary[400]!;

    final Color contentColor = isActive ? activeColor : inactiveColor;

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isActive ? colors.tertiary[50] : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(icon, color: contentColor, size: 26),
                  if (showNotification)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.medium10.copyWith(
                color: contentColor,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
