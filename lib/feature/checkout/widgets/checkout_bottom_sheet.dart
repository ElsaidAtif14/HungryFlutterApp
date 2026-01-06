import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class CheckoutBottomSheet extends StatelessWidget {
  const CheckoutBottomSheet({
    super.key,
    required this.totalPrice,
    required this.isLoading,
    required this.onPayNow,
  });

  final String totalPrice;
  final bool isLoading;
  final VoidCallback onPayNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
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
                const CustomText(
                  text: 'Total',
                  size: 20,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: totalPrice,
                  size: 27,
                ),
              ],
            ),
            isLoading
                ? const CupertinoActivityIndicator()
                : CustomButton(
                    text: 'Pay Now',
                    onTap: onPayNow,
                  ),
          ],
        ),
      ),
    );
  }
}
