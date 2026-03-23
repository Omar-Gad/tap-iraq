import 'package:flutter/material.dart';

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
        children: <Widget>[
          _buildItem(0, 'Cleaning', Icons.cleaning_services_rounded),
          _buildItem(1, 'Orders', Icons.list_alt_rounded),
          _buildItem(2, 'Profile', Icons.person_rounded),
          _buildItem(3, 'Settings', Icons.settings_rounded),
        ],
      ),
    );
  }

  Widget _buildItem(int index, String title, IconData icon) {
    return Expanded(
      child: _BottomNavBarItem(
        isActive: currentIndex == index,
        title: title,
        icon: icon,
        onTap: () => onTap(index),
      ),
    );
  }
}
