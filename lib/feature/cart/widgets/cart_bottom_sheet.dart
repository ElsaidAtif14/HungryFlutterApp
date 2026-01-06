import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/utils/app_router.dart';
import 'package:hungry/feature/cart/data/cart_model.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({
    super.key,
    required this.cartResponse,
  });

  final CartResponseModel? cartResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(text: 'Total', size: 16),
              CustomText(
                text:
                    '\$${(cartResponse != null && cartResponse!.data.items.isNotEmpty) ? cartResponse!.data.totalPrice : '0.00'}',
                size: 24,
              ),
            ],
          ),
          CustomButton(
            text: 'Checkout',
            onTap: () {
              GoRouter.of(context).push(
                '/root${AppRouter.kCheckout}',
                extra: {
                  'totalPrice': cartResponse?.data.totalPrice.toString() ?? '0.00',
                  'cartResponseModel': cartResponse,
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
