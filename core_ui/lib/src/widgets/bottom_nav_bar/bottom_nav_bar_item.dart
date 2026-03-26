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
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isActive ? colors.tertiary[50] : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(icon, color: contentColor, size: 24),
                  if (showNotification)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 8,
                          minHeight: 8,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                title.toUpperCase(),
                style: AppFonts.medium10.copyWith(
                  color: contentColor,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
