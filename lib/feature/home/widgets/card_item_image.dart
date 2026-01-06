import 'package:flutter/material.dart';

class CardItemImage extends StatelessWidget {
  const CardItemImage({
    super.key,
    required this.image,
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -10,
            child: image != null && image!.isNotEmpty
                ? Image.asset(
                    'assets/images/icons/shadow.png',
                    width: 120,
                  )
                : const SizedBox(),
          ),
          image != null && image!.isNotEmpty
              ? Image.network(
                  image!,
                  height: 120,
                  width: 120,
                  fit: BoxFit.contain,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
