import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, required this.text,this.width, this.color, this.height});
  final void Function()? onTap;
  final String text;
  final double? width; 
  final double? height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height??50,
        decoration: BoxDecoration(
          color:color?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Center(
            child: CustomText(
              text:text,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
