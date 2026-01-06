import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductBottomSheet extends StatelessWidget {
  const ProductBottomSheet({
    super.key,
    required this.productPrice,
    required this.productId,
    required this.value,
    required this.selectedToppings,
    required this.selectedSides,
    required this.isAddedLoading,
    required this.onAddToCart,
  });

  final String productPrice;
  final int productId;
  final double value;
  final List<int> selectedToppings;
  final List<int> selectedSides;
  final bool isAddedLoading;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade800,
            blurRadius: 15,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(text: 'Total', size: 20),
                CustomText(text: productPrice, size: 27),
              ],
            ),
            isAddedLoading
                ? const CupertinoActivityIndicator()
                : CustomButton(
                    text: 'Add to Cart',
                    onTap: onAddToCart,
                  ),
          ],
        ),
      ),
    );
  }
}
