import 'package:flutter/material.dart';
import 'package:hungry/feature/home/widgets/category_item.dart';

class FoodCategory extends StatefulWidget {
  const FoodCategory({
    super.key,
    required this.selectedIndex,
    required this.category,
  });
  final int selectedIndex;
  final List category;

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(widget.category.length, (index) {
          return CategoryItem(
            category: widget.category[index],
            isSelected: selectedIndex == index,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          );
        }),
      ),
    );
  }
}
