import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class ToppingCart extends StatelessWidget {
  const ToppingCart({
    super.key,
    required this.imageUrl,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  final String imageUrl;
  final String title;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Card(
          elevation: 3, // يزيد الelevation إذا مختار
          shadowColor: Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: isSelected
              ? Colors.green.shade200
              : Colors.white, // أخضر فاتح إذا مختار
          child: Container(
            width: 120,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isSelected
                  ? Colors.green.shade200
                  : Colors.white, // أخضر فاتح إذا مختار
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.fastfood,
                          color: Colors.grey,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
                Gap(6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CustomText(
                    text: title,
                    color: isSelected
                        ? Colors.white
                        : AppColors.primaryColor, // النص يعكس الاختيار
                    fontWeight: FontWeight.w600,
                    size: 15,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
