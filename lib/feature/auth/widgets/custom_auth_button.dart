
import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({super.key, required this.text, this.onTap, this.color, this.fontColor, this.width, this.fontweight, this.height, this.radius});
  final String text;
  final  Function()? onTap;
  final Color? color;
  final Color? fontColor;
  final double? width;
   final double? height;
  final FontWeight? fontweight;
   final double? radius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height??55,
        width:width?? double.infinity,
        decoration: BoxDecoration(
         
          color:color?? Colors.white,
          borderRadius: BorderRadius.circular(radius??10),
        ),
        
        child: Center(
          child: CustomText(
            text: text,
            size: 15,
            color:fontColor?? AppColors.primaryColor,
            fontWeight:fontweight?? FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
