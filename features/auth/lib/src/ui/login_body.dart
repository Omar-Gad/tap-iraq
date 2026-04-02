import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';
import '../../auth.gm.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitActive = false;


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.addListener(_listenFieldChanges);
    _passwordController.addListener(_listenFieldChanges);
  }

  @override
  void dispose() {
    _emailController.removeListener(_listenFieldChanges);
    _passwordController.removeListener(_listenFieldChanges);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _listenFieldChanges() {
    final bool isActive =
        _passwordController.text.isNotEmpty && _emailController.text.isNotEmpty;
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
          final bool isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                onChanged: _listenFieldChanges,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      localizations.welcome,
                      style: AppFonts.bold56.copyWith(letterSpacing: -1.4),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 80),
                    AppTextField(
                      label: localizations.email,
                      hintText: localizations.email_hint,
                      controller: _emailController,
                      validator: AppEmailValidator.validate,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 40),
                    AppPasswordField(
                      label: localizations.password,
                      hintText: localizations.password_hint,
                      controller: _passwordController,
                      validator: AppPasswordValidator.validate,
                      forgotPasswordText: localizations.forgot,

                      textInputAction: TextInputAction.done,
                      onForgotTap: () =>
                          AutoRouter.of(context).push(const ResetPasswordRoute()),
                    ),

                    const SizedBox(height: 64),
                    AppButton(
                      submitText: localizations.login,
                      isActive: _isSubmitActive && !isLoading,
                      isLoading: isLoading,
                      onSubmit: () {
                        if (!_formKey.currentState!.validate()) return;

                        FocusScope.of(context).unfocus();

                        context.read<AuthCubit>().login(
                              _emailController.text,
                              _passwordController.text,
                            );
                      },
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => AutoRouter.of(context).push(const RegisterRoute()),
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localizations.dont_have_account,
                            style: AppFonts.medium14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            localizations.create_account,
                            style: AppFonts.medium14.copyWith(
                              color: colors.tertiary[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );


  }
}

