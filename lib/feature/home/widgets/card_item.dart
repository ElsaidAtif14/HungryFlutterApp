import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/feature/home/widgets/card_item_details.dart';
import 'package:hungry/feature/home/widgets/card_item_image.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    this.image,
    required this.name,
    required this.desc,
    required this.rate,
  });

  final String? image;
  final String? name;
  final String? desc;
  final String? rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor,
              Colors.white60,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardItemImage(image: image),
              const Gap(10),
              Expanded(
                child: CardItemDetails(
                  name: name,
                  desc: desc,
                  rate: rate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
