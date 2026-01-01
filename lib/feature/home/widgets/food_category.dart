import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

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
    selectedIndex=widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(widget.category.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 27),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selectedIndex == index
                    ? AppColors.primaryColor
                    : Color(0xffF3F4F6),
              ),
              child: CustomText(
                color: selectedIndex == index ? Colors.white : Colors.black,

                text: widget.category[index],
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }),
      ),
    );
  }
}
