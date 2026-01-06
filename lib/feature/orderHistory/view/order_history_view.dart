import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/feature/orderHistory/data/order_history_model.dart';
import 'package:hungry/feature/orderHistory/data/order_history_repo.dart';
import 'package:hungry/feature/orderHistory/widgets/order_card.dart';
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
                  return OrderCard(order: order);
                },
              ),
            ),
    );
  }
}
