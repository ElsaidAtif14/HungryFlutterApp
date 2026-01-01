import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/feature/cart/data/cart_model.dart';
import 'package:hungry/feature/cart/data/cart_repo.dart';
import 'package:hungry/feature/cart/widgets/cart_item.dart';
import 'package:hungry/feature/checkout/view/check_out_view.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_snack_bar.dart';
import 'package:hungry/shared/custom_text.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: 'My Cart',
          fontWeight: FontWeight.bold,
          size: 24,
        ),
        toolbarHeight: 30,
        backgroundColor: Colors.white,
      ),
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
                      isRemoving: removingItemId == item.itemId, // هنا
                      onAdd: () => onAdd(index),
                      onMines: () => onMines(index),
                      onRemove: () => removeCartIteam(item.itemId),
                    );
                  },
                ),
              ),
            ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(text: 'Total', size: 16),
                CustomText(
                  text:
                      '\$${(cartResponse != null && cartResponse!.data.items.isNotEmpty) ? cartResponse!.data.totalPrice : '0.00'}',
                  size: 24,
                ),
              ],
            ),
            CustomButton(
              text: 'Checkout',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CheckOutView(
                    totalPrice:
                        cartResponse?.data.totalPrice.toString() ?? '0.00',
                    cartResponseModel: cartResponse!,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
