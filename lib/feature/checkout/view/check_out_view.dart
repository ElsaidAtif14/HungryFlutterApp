import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/utils/app_router.dart';
import 'package:hungry/feature/auth/data/auth_repo.dart';
import 'package:hungry/feature/auth/data/user_model.dart';
import 'package:hungry/feature/cart/data/cart_model.dart';
import 'package:hungry/feature/cart/data/cart_repo.dart';
import 'package:hungry/feature/checkout/widgets/checkout_bottom_sheet.dart';
import 'package:hungry/feature/checkout/widgets/order_deatil_widget.dart';
import 'package:hungry/feature/checkout/widgets/payment_methods_section.dart';
import 'package:hungry/feature/checkout/widgets/success_dialog.dart';
import 'package:hungry/feature/orderHistory/data/order_history_repo.dart';
import 'package:hungry/shared/custom_snack_bar.dart';
import 'package:hungry/shared/custom_text.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({
    super.key,
    required this.totalPrice,
    required this.cartResponseModel,
  });

  final CartResponseModel cartResponseModel;
  final String totalPrice;

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  OrderHistoryRepo orderHistoryRepo = OrderHistoryRepo();
  late String selectedMethod;
  double taxes = 3.5;
  double fees = 40.0;
  bool isAddedLoading = false;

  final AuthRepo authRepo = AuthRepo();
  final CartRepo cartRepo = CartRepo();

  UserModel? userModel;

  @override
  void initState() {
    selectedMethod = 'cash'; // default
    getProfileData();
    super.initState();
  }

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
        selectedMethod = userModel?.visa == null ? 'cash' : 'visa';
      });
    } catch (e) {
      String errmsg = 'Error In profile';
      if (e is ApiError) {
        errmsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errmsg));
    }
  }

  @override
  Widget build(BuildContext context) {
    double orderTotal = double.parse(widget.totalPrice) + taxes + fees;

    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0, backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Order summary',
                size: 20,
                fontWeight: FontWeight.w500,
              ),
              const Gap(10),
              OrderDeatilWidget(
                order: widget.totalPrice,
                taxes: taxes.toString(),
                fees: fees.toString(),
                total: orderTotal.toStringAsFixed(2),
              ),
              const Gap(40),
              PaymentMethodsSection(
                selectedMethod: selectedMethod,
                userModel: userModel,
                onMethodChanged: (method) {
                  setState(() => selectedMethod = method);
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: CheckoutBottomSheet(
        totalPrice: widget.cartResponseModel.data.totalPrice,
        isLoading: isAddedLoading,
        onPayNow: () async {
          try {
            setState(() => isAddedLoading = true);

            final cartItems = widget.cartResponseModel.data.items
                .map((item) {
                  return CartModel(
                    productId: item.productId,
                    quantity: item.quantity,
                    spicy: (item.spicy is String)
                        ? double.parse(item.spicy)
                        : (item.spicy as num).toDouble(),
                    toppings: item.toppings.map((t) => t.id).toList(),
                    sideOptions: item.sideOptions.map((s) => s.id).toList(),
                  );
                })
                .toList();

            final request = CartRequestModel(cartItems);

            await orderHistoryRepo.addToOrder(request);
            await cartRepo.clearCart(widget.cartResponseModel.data.items);
            showDialog(
              context: context,
              builder: (_) => Dialog(
                backgroundColor: Colors.transparent,
                child: SuccessDialog(
                  onTap: () {
                    GoRouter.of(context).pushReplacement(AppRouter.kRoot);
                  },
                ),
              ),
            );
          } catch (e) {
            String msg = 'Something went wrong ❌';
            if (e is ApiError && e.message.isNotEmpty) {
              msg = e.message;
            }
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(customSnackBar(msg));
          } finally {
            if (!mounted) return;
            setState(() => isAddedLoading = false);
          }
        },
      ),
    );
  }
}
