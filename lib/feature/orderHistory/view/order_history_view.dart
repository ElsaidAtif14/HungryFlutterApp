import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/feature/orderHistory/data/order_history_model.dart';
import 'package:hungry/feature/orderHistory/data/order_history_repo.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  final repo = OrderHistoryRepo();
  late Future<List<OrderHistoryModel>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = repo.getOrderHistory();
  }

  Future<void> _refresh() async {
    setState(() {
      _ordersFuture = repo.getOrderHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder<List<OrderHistoryModel>>(
          future: _ordersFuture,
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            }

            // Error
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final orders = snapshot.data;

            // Empty
            if (orders == null || orders.isEmpty) {
              return const Center(child: CustomText(text: 'No orders found'));
            }

            // Data
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 20, bottom: 110),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // صورة المنتج
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              order.productImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image, size: 100),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // معلومات الطلب
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Order #${order.id}',
                                  fontWeight: FontWeight.bold,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                const Gap(4),
                                CustomText(
                                  text: 'Date: ${order.createdAt}',
                                  size: 14,
                                  color: Colors.white60,
                                ),
                                const Gap(4),
                                CustomText(
                                  text: 'Status: ${order.status}',
                                  size: 14,
                                  color: order.status == 'confirmed'
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                                const Gap(4),
                                CustomText(
                                  text: 'Price: ${order.totalPrice}\$',
                                  size: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),

                                const Gap(10),

                                // زرار "Order Again"
                                SizedBox(
                                  width: double.infinity,
                                  child: CustomButton(
                                    text: 'Order Again',
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
