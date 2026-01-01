import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/feature/auth/data/user_model.dart';
import 'package:hungry/shared/custom_text.dart';
class UserHeader extends StatelessWidget {
  const UserHeader({super.key, this.userModel});

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              color: AppColors.primaryColor,
              height: 35,
            ),
            const Gap(5),
            CustomText(
              text: userModel == null
                  ? 'Hello'
                  : 'Hello, ${userModel!.name}',
              size: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 30,
          backgroundImage: userModel?.image == null
              ? null
              : NetworkImage(userModel!.image!),
        ),
      ],
    );
  }
}
