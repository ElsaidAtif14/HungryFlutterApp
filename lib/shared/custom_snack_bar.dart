import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

SnackBar customSnackBar(message) {
  return SnackBar(
    backgroundColor: AppColors.errColor,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
    behavior: SnackBarBehavior.floating,
    content: Row(
      children: [
        Icon(CupertinoIcons.info, color: Colors.white),
        Gap(10),
        Expanded(
          child: CustomText(
            text: message,
            color: Colors.white,
            size: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
