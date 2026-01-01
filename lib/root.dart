import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/feature/auth/view/profile_view.dart';
import 'package:hungry/feature/cart/view/cart_view.dart';
import 'package:hungry/feature/home/view/home_view.dart';
import 'package:hungry/feature/orderHistory/view/order_history_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentScreen = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = const [
      HomeView(),
      CartView(),
      OrderHistoryView(),
      ProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: IndexedStack(
          index: currentScreen,
          children: screens,
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Container(
              height: size.height * 0.10,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: AppColors.primaryColor,
              ),
              child: BottomNavigationBar(
                currentIndex: currentScreen,
                onTap: (index) {
                  setState(() {
                    currentScreen = index;
                  });
                },
                elevation: 0,
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade500.withOpacity(0.7),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.cart),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_restaurant_sharp),
                    label: 'Order History',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
