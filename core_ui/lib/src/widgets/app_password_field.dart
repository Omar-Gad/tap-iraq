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
    this.label = 'Password',
    this.hintText = 'Create a secure password',
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
              style: AppFonts.semiBold16.copyWith(
                color: colors.primary[900],
              ),
            ),
            if (widget.forgotPasswordText != null && widget.onForgotTap != null)
              GestureDetector(
                onTap: widget.onForgotTap,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.padding4,
                  ),
                  child: Text(
                    widget.forgotPasswordText!,
                    style: AppFonts.normal14.copyWith(
                      color: colors.secondary[600],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppDimens.padding8),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          style: AppFonts.medium14.copyWith(
            color: colors.primary[900],
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppFonts.normal14.copyWith(
              color: colors.neutral[400],
            ),
            filled: true,
            fillColor: colors.neutral[100],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimens.padding16,
              vertical: AppDimens.padding16,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.remove_red_eye_rounded
                    : Icons.visibility_off_rounded,
                color: colors.neutral[400],
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadius12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadius12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadius12),
              borderSide: BorderSide(
                color: colors.primary[500]!,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadius12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadius12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
