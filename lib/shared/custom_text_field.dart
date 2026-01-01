import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.isPassword,
    required this.controller,
  });
  final TextEditingController controller;
  final String hint;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;
  @override
  void initState() {
    _obscure = widget.isPassword;
    super.initState();
  }

  void togglePassword() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorHeight: 20,
       style: TextStyle(
    color: AppColors.primaryColor,     // لون النص
    fontSize: 16,            // حجم النص
    fontWeight: FontWeight.bold, // سمك النص
    fontStyle: FontStyle.normal, // لو عايز يميل
  ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill $widget.hint';
        }
        return null;
      },
      obscureText: _obscure,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  togglePassword();
                },
                icon: Icon(CupertinoIcons.eye, color: Colors.black),
              )
            : null,
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppColors.primaryColor),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
