import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/shared/custom_text.dart';

class OrderDeatilWidget extends StatelessWidget {
  const OrderDeatilWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.fees,
    required this.total,
  });
  final String order, taxes, fees, total;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          checkoutWidget('Order', order, false, false),
          Gap(10),
          checkoutWidget('Taxes', taxes, false, false),
          Gap(10),
          checkoutWidget('Delivery fees', fees, false, false),
          Gap(10),
          Divider(),
          Gap(10),
          checkoutWidget('Total:', total, true, false),
          Gap(10),
          checkoutWidget('Estimated delivery time:', '15 - 30 mins', true, true),
        ],
      ),
    );
  }
}

Widget checkoutWidget(title, price, isBold, isSmall) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        size: isSmall ? 13 : 16,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade600,
      ),
      CustomText(
        text: '$price\$',
        size: isSmall ? 13 : 16,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade600,
      ),
    ],
  );
}
