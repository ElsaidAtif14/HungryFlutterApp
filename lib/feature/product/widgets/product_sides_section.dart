import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/feature/home/data/model/side_options.dart';
import 'package:hungry/feature/product/widgets/topping_cart.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductSidesSection extends StatelessWidget {
  const ProductSidesSection({
    super.key,
    required this.sides,
    required this.selectedSides,
    required this.isLoading,
    required this.onSideSelected,
  });

  final List<SideOptionModel> sides;
  final List<int> selectedSides;
  final bool isLoading;
  final Function(SideOptionModel, bool) onSideSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Side Options',
          size: 20,
          fontWeight: FontWeight.w600,
        ),
        const Gap(20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              isLoading ? 3 : sides.length,
              (index) {
                final side = isLoading ? null : sides[index];
                final isSelected =
                    side != null && selectedSides.contains(side.id);

                return ToppingCart(
                  imageUrl: side?.image ?? '',
                  title: side?.name ?? 'Loading',
                  isSelected: isSelected,
                  onTap: () {
                    if (side == null) return;
                    onSideSelected(side, isSelected);
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
