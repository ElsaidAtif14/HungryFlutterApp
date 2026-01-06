import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/feature/auth/data/user_model.dart';
import 'package:hungry/shared/custom_text.dart';

class PaymentMethodsSection extends StatelessWidget {
  const PaymentMethodsSection({
    super.key,
    required this.selectedMethod,
    required this.userModel,
    required this.onMethodChanged,
  });

  final String selectedMethod;
  final UserModel? userModel;
  final Function(String) onMethodChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Payment methods',
          size: 20,
          fontWeight: FontWeight.w500,
        ),
        const Gap(20),
        // Cash
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          tileColor: const Color(0xff3C2F2F),
          leading: Image.asset(
            'assets/images/icons/dollar.png',
            width: 50,
          ),
          title: const CustomText(
            text: 'Cash on Delivery',
            color: Colors.white,
          ),
          trailing: Radio<String>(
            activeColor: Colors.white,
            value: 'cash',
            groupValue: selectedMethod,
            onChanged: (v) => onMethodChanged(v!),
          ),
          onTap: () => onMethodChanged('cash'),
        ),
        const Gap(20),
        // Visa
        if (userModel?.visa != null)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            tileColor: Colors.blue.shade900,
            leading: Image.asset(
              'assets/images/icons/profileVisa.png',
              width: 50,
            ),
            title: const CustomText(
              text: 'Debit card',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            subtitle: CustomText(
              text: userModel!.visa!,
              color: Colors.white,
            ),
            trailing: Radio<String>(
              activeColor: Colors.white,
              value: 'visa',
              groupValue: selectedMethod,
              onChanged: (v) => onMethodChanged(v!),
            ),
            onTap: () => onMethodChanged('visa'),
          ),
        const Gap(300),
      ],
    );
  }
}
