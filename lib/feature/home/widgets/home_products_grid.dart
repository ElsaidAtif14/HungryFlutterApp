import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/utils/app_router.dart';
import 'package:hungry/feature/home/data/model/product_model.dart';
import 'package:hungry/feature/home/widgets/card_item.dart';
import 'package:hungry/feature/home/widgets/food_category.dart';

class HomeProductsGrid extends StatelessWidget {
  const HomeProductsGrid({
    super.key,
    required this.selectedIndex,
    required this.category,
    required this.filteredProducts,
  });

  final int selectedIndex;
  final List category;
  final List<ProductModel> filteredProducts;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Column(
          children: [
            const Gap(25),
            FoodCategory(
              selectedIndex: selectedIndex,
              category: category,
            ),
            const Gap(25),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 2,
          child: GridView.builder(
            clipBehavior: Clip.none,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 8,
              childAspectRatio: 0.72,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return GestureDetector(
                onTap: () {
                  
                  GoRouter.of(context).push(
                    '/root${AppRouter.kProductDetails}',
                    extra: {
                      'productId': product.id,
                      'productImage': product.image,
                      'productName': product.name,
                      'productPrice': product.price,
                    },
                  );
                },
                child: CardItem(
                  image: product.image,
                  name: product.name,
                  desc: product.description,
                  rate: product.price,
                ),
              );
            },
          ),
        ),
       
      ]),
    );
  }
}
