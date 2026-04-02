import 'package:flutter/material.dart';

class AdaptiveBuilder extends StatelessWidget {
  final Widget enView;
  final Widget arView;

  const AdaptiveBuilder({
    required this.enView,
    required this.arView,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String languageCode = Localizations.localeOf(context).languageCode;
    return languageCode == 'ar' ? arView : enView;
  }
}
