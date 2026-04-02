import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

part 'bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final currentIndex = _getCurrentIndex(router.currentPath);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        bottom: 24,
        top: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildItem(context, 0, currentIndex, 'Home', Icons.home_rounded),
          _buildItem(context, 1, currentIndex, 'Bookings',
              Icons.calendar_month_rounded),
          _buildItem(
              context, 2, currentIndex, 'Addresses', Icons.location_on_rounded),
          _buildItem(context, 3, currentIndex, 'Profile', Icons.person_rounded),
        ],
      ),
    );
  }

  int _getCurrentIndex(String path) {
    if (path.contains('cleaning')) return 0;
    if (path.contains('orders')) return 1;
    if (path.contains('addresses')) return 2;
    if (path.contains('profile')) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    final router = context.router;
    switch (index) {
      case 0:
        router.navigateNamed('cleaning');
        break;
      case 1:
        router.navigateNamed('orders');
        break;
      case 2:
        router.navigateNamed('addresses');
        break;
      case 3:
        router.navigateNamed('profile');
        break;
    }
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    int currentIndex,
    String title,
    IconData icon,
  ) {
    return _BottomNavBarItem(
      isActive: currentIndex == index,
      title: title,
      icon: icon,
      onTap: () => _onTap(context, index),
    );
  }
}
