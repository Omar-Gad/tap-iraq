import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

@RoutePage()
class AddAddressBody extends StatefulWidget {
  final UserAddress? address;

  const AddAddressBody({super.key, this.address});

  @override
  State<AddAddressBody> createState() => _AddAddressBodyState();
}

class _AddAddressBodyState extends State<AddAddressBody> {
  late final TextEditingController _labelController;
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _zipCodeController;

  bool _isSaving = false;

  bool get _isEditMode => widget.address != null;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.address?.label ?? '');
    _streetController =
        TextEditingController(text: widget.address?.street ?? '');
    _cityController = TextEditingController(text: widget.address?.city ?? '');
    _zipCodeController =
        TextEditingController(text: widget.address?.zipCode ?? '');
  }

  @override
  void dispose() {
    _labelController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  void _onSaveAddress() {
    if (_labelController.text.trim().isEmpty ||
        _streetController.text.trim().isEmpty ||
        _cityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final newAddress = UserAddress(
      id: widget.address?.id ?? 0,
      userId: widget.address?.userId ?? 1,
      label: _labelController.text.trim(),
      street: _streetController.text.trim(),
      city: _cityController.text.trim(),
      zipCode: _zipCodeController.text.trim(),
      isDefault: widget.address?.isDefault ?? false,
    );

    if (_isEditMode) {
      context.read<AddressCubit>().updateAddress(newAddress);
    } else {
      context.read<AddressCubit>().addAddress(newAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final localizations = AppLocalizations.of(context)!;

    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is AddressError) {
          setState(() {
            _isSaving = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AddressLoaded && _isSaving) {
          context.router.maybePop();
        }
      },
      builder: (context, state) {
        final isLoading = state is AddressLoading && _isSaving;

        return Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(
            title:
                Text(_isEditMode ? 'Edit Address' : localizations.add_address),
            backgroundColor: colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: colors.black),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  AppTextField(
                    controller: _labelController,
                    label: localizations.address_label,
                    hintText: localizations.address_label_hint,
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    controller: _streetController,
                    hintText: localizations.street_address_hint,
                    label: localizations.street_address,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _cityController,
                          hintText: localizations.city_hint,
                          label: localizations.city,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextField(
                          controller: _zipCodeController,
                          hintText: localizations.zip_code_hint,
                          label: localizations.zip_code,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: colors.neutral[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, color: colors.primary),
                            const SizedBox(width: 8),
                            Text(
                              localizations.access_note.toUpperCase(),
                              style:
                                  AppFonts.bold14.copyWith(letterSpacing: 0.7),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          localizations.please_provide,
                          style: AppFonts.normal14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  AppButton(
                    submitText: _isEditMode
                        ? localizations.save_changes
                        : localizations.add_address,
                    isActive: !isLoading,
                    isLoading: isLoading,
                    onSubmit: _onSaveAddress,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
