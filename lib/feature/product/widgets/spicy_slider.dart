import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.isLoading,
    required this.imageUrl,
  });
  final double value;
  final ValueChanged<double> onChanged;
  final bool isLoading;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isLoading
            ? SizedBox()
            : Image.network(imageUrl, width: 180, height: 180),
        Spacer(),
        Column(
          children: [
            CustomText(
              text:
                  'Customize Your Burger\n to Your Tastes. Ultimate\n Experience',
              fontWeight: FontWeight.w600,
            ),
            Slider(
              min: 0,
              max: 1,
              divisions: 10,
              value: value,
              activeColor: AppColors.primaryColor,
              thumbColor: AppColors.primaryColor,
              onChanged: onChanged,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomText(text: '🥶'),
                Gap(100),
                CustomText(text: '🌶️'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
