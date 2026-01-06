import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CartRemoveButton extends StatelessWidget {
  const CartRemoveButton({
    super.key,
    required this.isRemoving,
    required this.onRemove,
  });

  final bool isRemoving;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 130,
      child: isRemoving
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : GestureDetector(
              onTap: onRemove,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: CustomText(
                    text: 'Remove',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
    );
  }
}
