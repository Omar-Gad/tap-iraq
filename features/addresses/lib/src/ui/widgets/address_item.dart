import 'package:addresses/addresses.gm.dart';
import 'package:addresses/src/ui/widgets/item_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/home.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.address});
  final UserAddress address;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: address.isDefault
            ? Border.all(color: colors.tertiary, width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                address.label,
                style: AppFonts.bold24.copyWith(letterSpacing: -0.6),
              ),
              if (address.isDefault) ...[
                const SizedBox(width: 8),
                Icon(Icons.check_circle_rounded, color: colors.gold)
              ],
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.router.push(AddAddressRoute(address: address));
                },
                icon: Icon(Icons.edit_outlined, color: colors.primary[400]),
              ),
              IconButton(
                onPressed: () {
                  context
                      .read<AddressCubit>()
                      .deleteAddress(address.userId, address.id!);
                },
                icon: Icon(Icons.delete_outline_rounded, color: colors.red),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.street, style: AppFonts.normal16),
                Text(
                  '${address.city}, ${address.zipCode}',
                  style: AppFonts.normal16,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (address.isDefault) ...[
            Divider(color: colors.neutral[400], thickness: 2),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: colors.tertiary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                localizations.primary_address.toUpperCase(),
                style: AppFonts.bold10.copyWith(color: colors.tertiary),
              ),
            ),
          ] else ...[
            ItemButton(
              text: localizations.select_for_request.toUpperCase(),
              onTap: () {
                context
                    .read<AddressCubit>()
                    .setDefaultAddress(address.userId, address.id!);
              },
            ),
          ],
        ],
      ),
    );
  }
}
