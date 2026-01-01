import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      shadowColor: Colors.grey,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.search),
          hintText: 'Search...',
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
