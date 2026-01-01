import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/feature/auth/data/auth_repo.dart';
import 'package:hungry/feature/auth/data/user_model.dart';
import 'package:hungry/feature/cart/data/cart_model.dart';
import 'package:hungry/feature/cart/data/cart_repo.dart';
import 'package:hungry/feature/checkout/widgets/order_deatil_widget.dart';
import 'package:hungry/feature/checkout/widgets/success_dialog.dart';
import 'package:hungry/feature/orderHistory/data/order_history_repo.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/custom_button.dart';
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
              const CustomText(
                text: 'Payment methods',
                size: 20,
                fontWeight: FontWeight.w500,
              ),
              const Gap(20),

              // Cash
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: const Color(0xff3C2F2F),
                leading: Image.asset(
                  'assets/images/icons/dollar.png',
                  width: 50,
                ),
                title: const CustomText(
                  text: 'Cash on Delivery',
                  color: Colors.white,
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'cash',
                  groupValue: selectedMethod,
                  onChanged: (v) => setState(() => selectedMethod = v!),
                ),
                onTap: () => setState(() => selectedMethod = 'cash'),
              ),

              const Gap(20),

              // Visa
              if (userModel?.visa != null)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  tileColor: Colors.blue.shade900,
                  leading: Image.asset(
                    'assets/images/icons/profileVisa.png',
                    width: 50,
                  ),
                  title: const CustomText(
                    text: 'Debit card',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  subtitle: CustomText(
                    text: userModel!.visa!,
                    color: Colors.white,
                  ),
                  trailing: Radio<String>(
                    activeColor: Colors.white,
                    value: 'visa',
                    groupValue: selectedMethod,
                    onChanged: (v) => setState(() => selectedMethod = v!),
                  ),
                  onTap: () => setState(() => selectedMethod = 'visa'),
                ),

              const Gap(300),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
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
                children: [
                  const CustomText(
                    text: 'Total',
                    size: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: widget.cartResponseModel.data.totalPrice,
                    size: 27,
                  ),
                ],
              ),
              isAddedLoading
                  ? CupertinoActivityIndicator()
                  : CustomButton(
                      text: 'Pay Now',
                      onTap: () async {
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
                                  toppings: item.toppings
                                      .map((t) => t.id)
                                      .toList(),
                                  sideOptions: item.sideOptions
                                      .map((s) => s.id)
                                      .toList(),
                                );
                              })
                              .toList();

                          final request = CartRequestModel(cartItems);

                          await orderHistoryRepo.addToOrder(request);
                          await cartRepo.clearCart(widget.cartResponseModel.data.items);
                          showDialog(
                            context: context,
                            builder: (_) =>  Dialog(
                              backgroundColor: Colors.transparent,
                              child: SuccessDialog(
                                onTap: () {
                                Navigator.pop(context);
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
            ],
          ),
        ),
      ),
    );
  }
}
