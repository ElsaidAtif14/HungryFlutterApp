
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';

class CustomProfileCard extends StatelessWidget {
  const CustomProfileCard({
    super.key,  this.image, this.imagePath,
  });
  final String? image;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: AppColors.primaryColor),
        image: DecorationImage(
          fit: BoxFit.contain,
          image: FileImage(File('ImagePath'))
        ),
        color: Colors.white,
       
      ),
    );
  }
}
