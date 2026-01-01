import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';

class CustomUserTextField extends StatelessWidget {
  const CustomUserTextField({
    super.key,
    required this.controller,
    required this.label, this.textInputType,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      controller: controller,
      style: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 18, // حجم النص أكبر
      ),
      cursorColor: AppColors.primaryColor,
      cursorHeight: 22, // طول المؤشر أكبر

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ), // زيادة مساحة الحقل
        label: Text(
          label,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16, // حجم الـ label
          ),
        ),
        enabledBorder: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(25), // radius أكبر
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25), // radius أكبر عند التركيز
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
    );
  }
}
