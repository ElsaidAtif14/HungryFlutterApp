import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key, this.onTap});
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 200),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                CupertinoIcons.check_mark,
                color: Colors.white,
                size: 30,
              ),
            ),
            Gap(10),
            CustomText(
              text: 'Success !',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
              size: 30,
            ),
            Gap(8),
            CustomText(
              text:
                  'Your payment was successful.\nA receipt for this purchase has \nbeen sent to your email.',
                  size: 11,
                  color: Colors.grey.shade700,
                  textAlign: TextAlign.center,
            ),
            Gap(30),
            CustomButton(text:'Close',width: 180,onTap:onTap,)
          ],
        ),
      ),
    );
  }
}
