import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/feature/cart/data/cart_model.dart';
import 'package:hungry/feature/cart/data/cart_repo.dart';
import 'package:hungry/feature/cart/widgets/cart_app_bar.dart';
import 'package:hungry/feature/cart/widgets/cart_bottom_sheet.dart';
import 'package:hungry/feature/cart/widgets/cart_item.dart';
import 'package:hungry/shared/custom_snack_bar.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> quantities;
  final CartRepo cartRepo = CartRepo();
  CartResponseModel? cartResponse;

  bool isLoading = true;
  int? removingItemId; // ID العنصر اللي بيتحذف

  void onAdd(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void onMines(int index) {
    setState(() {
      if (quantities[index] > 1) {
        quantities[index]--;
      }
    });
  }

  Future<void> removeCartIteam(int itemId) async {
    setState(() {
      removingItemId = itemId;
    });

    try {
      await cartRepo.removeCartItem(itemId);
      await fetchCart();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar('Item removed from cart successfully ✅'));
      // تحديث الكارت بعد الحذف
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(e.toString()));
    } finally {
      setState(() {
        removingItemId = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  Future<void> fetchCart() async {
    try {
      final res = await cartRepo.getCartResponse();
      setState(() {
        cartResponse = res;
        quantities = List.generate(res.data.items.length, (_) => 1);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CartAppBar(),
      body: isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : RefreshIndicator(
              onRefresh: fetchCart,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10, bottom: 110),
                  itemCount: cartResponse?.data.items.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = cartResponse!.data.items[index];

                    return CartItem(
                      image: item.image,
                      text: item.name,
                      desc: '',
                      number: quantities[index],
                      isRemoving: removingItemId == item.itemId,
                      onAdd: () => onAdd(index),
                      onMines: () => onMines(index),
                      onRemove: () => removeCartIteam(item.itemId),
                    );
                  },
                ),
              ),
            ),
      bottomSheet: CartBottomSheet(
        cartResponse: cartResponse,
      ),
    );
  }
}
