import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ItemButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Material(
      color: colors.neutral,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Text(
              text,
              style: AppFonts.bold12.copyWith(
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
