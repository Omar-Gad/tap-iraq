import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final TextEditingController _emailController;
  bool _isSubmitActive = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailController.addListener(_listenFieldChanges);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _listenFieldChanges() {
    final bool isActive = _emailController.text.isNotEmpty;
    if (isActive != _isSubmitActive) {
      setState(() {
        _isSubmitActive = isActive;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.white,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => AutoRouter.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 16),
                  Text(localizations.reset_password, style: AppFonts.bold28),
                  const SizedBox(height: 24),
                  Text(localizations.enter_email, style: AppFonts.medium16),
                  const SizedBox(height: 56),
                  AppTextField(
                    label: localizations.email,
                    hintText: localizations.email_hint,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 80),
                  AppButton(
                    submitText: localizations.send_link,
                    isActive: _isSubmitActive && !isLoading,
                    isLoading: isLoading,
                    onSubmit: () {
                      FocusScope.of(context).unfocus();
                      // Placeholder for reset password logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Not implemented yet')),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: colors.neutral,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

  }
}


