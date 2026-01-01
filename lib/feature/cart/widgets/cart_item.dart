import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';
class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.number,
    required this.isRemoving, // 👈 جديد
    this.onMines,
    this.onAdd,
    this.onRemove,
  });

  final String image, text, desc;
  final int number;
  final bool isRemoving; // 👈 جديد
  final Function()? onMines;
  final Function()? onAdd;
  final Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// -------- Left --------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(image, width: 100),
                Container(
                  width: 150,
                  child: CustomText(
                    text: text,
                    fontWeight: FontWeight.bold,
                    size: 16,
                  ),
                ),
                CustomText(text: desc),
              ],
            ),

            /// -------- Right --------
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onAdd,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: const Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Gap(20),
                    CustomText(
                      text: '$number',
                      size: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const Gap(20),
                    GestureDetector(
                      onTap: onMines,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: const Icon(
                          CupertinoIcons.minus,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),

                /// -------- Remove Button / Loading --------
                SizedBox(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
