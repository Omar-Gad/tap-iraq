import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';
import '../../auth.gm.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitActive = false;


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _emailController.addListener(_listenFieldChanges);
    _passwordController.addListener(_listenFieldChanges);
    _confirmPasswordController.addListener(_listenFieldChanges);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _listenFieldChanges() {
    final bool isActive = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;

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
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.step == AuthStep.userRegister) {
            AutoRouter.of(context).push(const UserRegisterRoute());
          }
        },
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
                    const SizedBox(height: 40),
                    AppTextField(
                      label: localizations.email,
                      hintText: localizations.email_hint,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: AppEmailValidator.validate,
                    ),
                    const SizedBox(height: 24),
                    AppPasswordField(
                      label: localizations.password,
                      hintText: localizations.password_hint,
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      validator: AppPasswordValidator.validate,
                    ),
                    const SizedBox(height: 24),
                    AppPasswordField(
                      label: localizations.confirm_password,
                      hintText: localizations.password_hint,
                      controller: _confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      validator: AppConfirmPasswordValidator.validate(
                          _passwordController.text),
                    ),
                    const SizedBox(height: 40),
                    AppButton(
                      submitText: localizations.create_account,
                      isActive: _isSubmitActive && !isLoading,
                      isLoading: isLoading,
                      onSubmit: () {
                        if (!_formKey.currentState!.validate()) return;

                        FocusScope.of(context).unfocus();
                        context.read<AuthCubit>().saveCredentials(
                              _emailController.text,
                              _passwordController.text,
                            );
                      },
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => AutoRouter.of(context).pop(),
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localizations.already_have_account,
                            style: AppFonts.medium14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            localizations.login,
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

