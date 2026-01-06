import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(145),
        CustomText(
          text: '@ john Snow 2019',
          color: AppColors.primaryColor,
          size: 14,
          fontWeight: FontWeight.bold,
        ),
        const Gap(30),
      ],
    );
  }
}
