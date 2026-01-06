import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CartItemControls extends StatelessWidget {
  const CartItemControls({
    super.key,
    required this.number,
    required this.onAdd,
    required this.onMines,
  });

  final int number;
  final VoidCallback? onAdd;
  final VoidCallback? onMines;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onAdd,
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: const Icon(
              CupertinoIcons.add,
              color: Colors.white,
            ),
          ),
        ),
        const Gap(20),
        CustomText(
          text: '$number',
          size: 20,
          fontWeight: FontWeight.bold,
        ),
        const Gap(20),
        GestureDetector(
          onTap: onMines,
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: const Icon(
              CupertinoIcons.minus,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
