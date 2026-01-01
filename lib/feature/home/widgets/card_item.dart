import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

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
            end: Alignment.bottomRight,
            colors: [AppColors.primaryColor,AppColors.primaryColor.withOpacity(0.2), Colors.white60, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -10,
                      child: image != null && image!.isNotEmpty
                          ? Image.asset(
                              'assets/images/icons/shadow.png',
                              width: 120,
                            )
                          : SizedBox(),
                    ),
                    image != null && image!.isNotEmpty
                        ? Image.network(
                            image!,
                            height: 120,
                            width: 120,
                            fit: BoxFit.contain,
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              Gap(10),
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
                  Spacer(),
                  Icon(CupertinoIcons.heart_fill, color: Colors.red.shade500),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
