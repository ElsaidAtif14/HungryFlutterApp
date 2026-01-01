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
  List<OrderHistoryModel>? orders;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    setState(() => isLoading = true);

    try {
      final res = await repo.getOrderHistory();
      setState(() {
        orders = res;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _refresh() async {
    await fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : (orders == null || orders!.isEmpty)
          ? const Center(child: CustomText(text: 'No orders found'))
          : RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 20, bottom: 110),
          itemCount: orders!.length,
          itemBuilder: (context, index) {
            final order = orders![index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical :8),
              child: Card(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
