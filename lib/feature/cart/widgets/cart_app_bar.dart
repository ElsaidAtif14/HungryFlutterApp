import 'package:flutter/material.dart';
import 'package:hungry/shared/custom_text.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const CustomText(
        text: 'My Cart',
        fontWeight: FontWeight.bold,
        size: 24,
      ),
      toolbarHeight: 30,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(30);
}
