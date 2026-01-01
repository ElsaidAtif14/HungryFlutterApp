import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/feature/cart/data/cart_model.dart';
import 'package:hungry/feature/cart/data/cart_repo.dart';
import 'package:hungry/feature/home/data/model/side_options.dart';
import 'package:hungry/feature/home/data/model/topping_model.dart';
import 'package:hungry/feature/home/data/repos/product_repo.dart';
import 'package:hungry/feature/product/widgets/spicy_slider.dart';
import 'package:hungry/feature/product/widgets/topping_cart.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_snack_bar.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView( {
    super.key,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productPrice
  });

  final int productId;
  final String productImage;
  final String productName;
  final String productPrice;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final ProductRepo _repo = ProductRepo();
  final CartRepo cartRepo = CartRepo();

  double value = 0.5;
  bool isLoading = true;
  bool isAddedLoading = false;

  List<int> selectedToppings = [];
  List<int> selectedSides = [];

  List<ToppingModel> toppings = [];
  List<SideOptionModel> sides = [];

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        _repo.getToppings(),
        _repo.getSideOptions(),
      ]);

      if (!mounted) return;

      setState(() {
        toppings = results[0] as List<ToppingModel>;
        sides = results[1] as List<SideOptionModel>;
        isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          widget.productName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Skeletonizer(
        enabled: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpicySlider(
                  imageUrl: widget.productImage,
                  value: value,
                  isLoading: isLoading,
                  onChanged: (v) => setState(() => value = v),
                ),
                const Gap(20),

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
                        final topping =
                            isLoading ? null : toppings[index];
                        final isSelected = topping != null &&
                            selectedToppings.contains(topping.id);

                        return ToppingCart(
                          imageUrl: topping?.image ?? '',
                          title: topping?.name ?? 'Loading',
                          isSelected: isSelected,
                          onTap: () {
                            if (topping == null) return;
                            setState(() {
                              isSelected
                                  ? selectedToppings.remove(topping.id)
                                  : selectedToppings.add(topping.id);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),

                const Gap(40),

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
                            setState(() {
                              isSelected
                                  ? selectedSides.remove(side.id)
                                  : selectedSides.add(side.id);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
                const Gap(200),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 15,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  CustomText(text: 'Total', size: 20),
                  CustomText(text: widget.productPrice, size: 27),
                ],
              ),
              isAddedLoading
                  ? const CupertinoActivityIndicator()
                  : CustomButton(
                      text: 'Add to Cart',
                      onTap: () async {
                        final cartItem = CartModel(
                          productId: widget.productId,
                          quantity: 1,
                          spicy: value,
                          toppings: selectedToppings,
                          sideOptions: selectedSides,
                        );

                        try {
                          setState(() => isAddedLoading = true);

                          await cartRepo.addToCart(
                            CartRequestModel([cartItem]),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar('Added to cart successfully ✅'),
                          );
                        } catch (e) {
                          String errorMessage =
                              ' Something went wrong ❌';

                          if (e is ApiError && e.message.isNotEmpty) {
                            errorMessage = e.message;
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(errorMessage),
                          );
                        } finally {
                          if (!mounted) return;
                          setState(() => isAddedLoading = false);
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
