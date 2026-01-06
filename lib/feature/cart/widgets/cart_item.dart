import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/feature/cart/widgets/cart_item_controls.dart';
import 'package:hungry/feature/cart/widgets/cart_remove_button.dart';
import 'package:hungry/shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.number,
    required this.isRemoving,
    this.onMines,
    this.onAdd,
    this.onRemove,
  });

  final String image, text, desc;
  final int number;
  final bool isRemoving;
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
                SizedBox(
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
                CartItemControls(
                  number: number,
                  onAdd: onAdd,
                  onMines: onMines,
                ),
                const Gap(20),
                CartRemoveButton(
                  isRemoving: isRemoving,
                  onRemove: onRemove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
