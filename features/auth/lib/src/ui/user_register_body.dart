import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

@RoutePage()
class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitActive = false;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();

    _nameController.addListener(_listenFieldChanges);
    _phoneController.addListener(_listenFieldChanges);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _listenFieldChanges() {
    final bool isActive =
        _nameController.text.isNotEmpty && _phoneController.text.isNotEmpty;
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
              child: Form(
                key: _formKey,
                onChanged: _listenFieldChanges,
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
                    Text(
                      localizations.join_our,
                      style: AppFonts.bold36.copyWith(letterSpacing: -1.4),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      localizations.sanctuary,
                      style: AppFonts.bold36
                          .copyWith(letterSpacing: -1.4, color: colors.tertiary),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 260,
                      child: Text(
                        localizations.experience_text,
                        style: AppFonts.normal16,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 48),
                    AppTextField(
                      label: localizations.full_name,
                      hintText: localizations.full_name_hint,
                      controller: _nameController,
                      validator: AppNameValidator.validate,
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      label: localizations.phone,
                      hintText: "000-000-00-00",
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: AppPhoneValidator.validate,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      localizations.we_will_send_otp,
                      style: AppFonts.normal14.copyWith(
                        color: colors.primary[900],
                      ),
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      isActive: _isSubmitActive && !isLoading,
                      isLoading: isLoading,
                      submitText: localizations.continue_text,
                      onSubmit: () {
                        if (!_formKey.currentState!.validate()) return;

                        FocusScope.of(context).unfocus();
                        context.read<AuthCubit>().registerFinal(
                              name: _nameController.text,
                              phone: _phoneController.text,
                            );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: colors.white,
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

