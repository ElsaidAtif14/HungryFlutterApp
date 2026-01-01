import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines = 2,
  });

  final String text;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
