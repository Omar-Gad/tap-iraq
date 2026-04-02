import 'package:flutter/material.dart';

import '../../core_ui.dart';

class AppPasswordField extends StatefulWidget {
  final String label;
  final String hintText;
  final String? forgotPasswordText;
  final VoidCallback? onForgotTap;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;

  const AppPasswordField({
    required this.label,
    required this.hintText,
    this.validator,
    this.controller,
    this.forgotPasswordText,
    this.onForgotTap,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    super.key,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: AppFonts.bold20.copyWith(
                color: colors.primary[500],
              ),
            ),
            if (widget.forgotPasswordText != null && widget.onForgotTap != null)
              GestureDetector(
                onTap: widget.onForgotTap,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  child: Text(
                    widget.forgotPasswordText!,
                    style: AppFonts.normal16.copyWith(
                      color: colors.secondary[500],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6.0),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          style: AppFonts.medium14.copyWith(
            color: colors.primary[500],
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorStyle: const TextStyle(fontSize: 12, height: 1),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.remove_red_eye_rounded
                    : Icons.visibility_off_rounded,
                color: colors.primary[500]!.withOpacity(0.4),
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),

      ],
    );
  }
}
