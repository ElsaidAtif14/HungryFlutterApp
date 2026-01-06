import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(120),
        SvgPicture.asset(
          'assets/images/logo.svg',
          color: AppColors.primaryColor,
        ),
        const Gap(8),
        CustomText(
          color: AppColors.primaryColor,
          text: title,
          fontWeight: FontWeight.bold,
        ),
        const Gap(60),
      ],
    );
  }
}
