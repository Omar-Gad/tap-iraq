import 'package:flutter/material.dart';

import '../../theme/theme.dart';

part 'bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          _buildItem(0, 'Home', Icons.home_rounded),
          _buildItem(1, 'Bookings', Icons.calendar_month_rounded),
          _buildItem(2, 'Addresses', Icons.location_on_rounded),
          _buildItem(3, 'Profile', Icons.person_rounded),
        ],
      ),
    );
  }

  Widget _buildItem(int index, String title, IconData icon) {
    return _BottomNavBarItem(
      isActive: currentIndex == index,
      title: title,
      icon: icon,
      onTap: () => onTap(index),
    );
  }
}
