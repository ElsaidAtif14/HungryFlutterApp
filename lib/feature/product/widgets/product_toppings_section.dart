import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/feature/home/data/model/topping_model.dart';
import 'package:hungry/feature/product/widgets/topping_cart.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductToppingsSection extends StatelessWidget {
  const ProductToppingsSection({
    super.key,
    required this.toppings,
    required this.selectedToppings,
    required this.isLoading,
    required this.onToppingSelected,
  });

  final List<ToppingModel> toppings;
  final List<int> selectedToppings;
  final bool isLoading;
  final Function(ToppingModel, bool) onToppingSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Toppings',
          size: 20,
          fontWeight: FontWeight.w600,
        ),
        const Gap(20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              isLoading ? 3 : toppings.length,
              (index) {
                final topping = isLoading ? null : toppings[index];
                final isSelected =
                    topping != null && selectedToppings.contains(topping.id);

                return ToppingCart(
                  imageUrl: topping?.image ?? '',
                  title: topping?.name ?? 'Loading',
                  isSelected: isSelected,
                  onTap: () {
                    if (topping == null) return;
                    onToppingSelected(topping, isSelected);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
