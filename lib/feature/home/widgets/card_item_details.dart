import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/shared/custom_text.dart';

class CardItemDetails extends StatelessWidget {
  const CardItemDetails({
    super.key,
    required this.name,
    required this.desc,
    required this.rate,
  });

  final String? name;
  final String? desc;
  final String? rate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: name ?? '',
                fontWeight: FontWeight.bold,
                maxLines: 1,
              ),
              CustomText(text: desc ?? '', maxLines: 2),
            ],
          ),
        ),
        Row(
          children: [
            CustomText(text: '⭐ ${rate ?? '0.0'}'),
            const Spacer(),
            Icon(CupertinoIcons.heart_fill, color: Colors.red.shade500),
          ],
        ),
      ],
    );
  }
}
