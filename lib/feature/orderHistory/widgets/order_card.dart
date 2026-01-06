import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/feature/orderHistory/data/order_history_model.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
  });

  final OrderHistoryModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  order.productImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image, size: 100),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Order #${order.id}',
                      fontWeight: FontWeight.bold,
                      size: 16,
                      color: Colors.white,
                    ),
                    const Gap(4),
                    CustomText(
                      text: 'Date: ${order.createdAt}',
                      size: 14,
                      color: Colors.white60,
                    ),
                    const Gap(4),
                    CustomText(
                      text: 'Status: ${order.status}',
                      size: 14,
                      color: order.status == 'confirmed'
                          ? Colors.green
                          : Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                    const Gap(4),
                    CustomText(
                      text: 'Price: ${order.totalPrice}\$',
                      size: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const Gap(10),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'Order Again',
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
