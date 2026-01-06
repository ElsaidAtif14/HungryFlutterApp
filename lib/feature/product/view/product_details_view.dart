import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/feature/cart/data/cart_model.dart';
import 'package:hungry/feature/cart/data/cart_repo.dart';
import 'package:hungry/feature/home/data/model/side_options.dart';
import 'package:hungry/feature/home/data/model/topping_model.dart';
import 'package:hungry/feature/home/data/repos/product_repo.dart';
import 'package:hungry/feature/product/widgets/product_bottom_sheet.dart';
import 'package:hungry/feature/product/widgets/product_sides_section.dart';
import 'package:hungry/feature/product/widgets/product_toppings_section.dart';
import 'package:hungry/feature/product/widgets/spicy_slider.dart';
import 'package:hungry/shared/custom_snack_bar.dart';
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
                ProductToppingsSection(
                  toppings: toppings,
                  selectedToppings: selectedToppings,
                  isLoading: isLoading,
                  onToppingSelected: (topping, isSelected) {
                    setState(() {
                      isSelected
                          ? selectedToppings.remove(topping.id)
                          : selectedToppings.add(topping.id);
                    });
                  },
                ),
                const Gap(40),
                ProductSidesSection(
                  sides: sides,
                  selectedSides: selectedSides,
                  isLoading: isLoading,
                  onSideSelected: (side, isSelected) {
                    setState(() {
                      isSelected
                          ? selectedSides.remove(side.id)
                          : selectedSides.add(side.id);
                    });
                  },
                ),
                const Gap(200),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: ProductBottomSheet(
        productPrice: widget.productPrice,
        productId: widget.productId,
        value: value,
        selectedToppings: selectedToppings,
        selectedSides: selectedSides,
        isAddedLoading: isAddedLoading,
        onAddToCart: () async {
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
            String errorMessage = ' Something went wrong ❌';

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
    );
  }
}
