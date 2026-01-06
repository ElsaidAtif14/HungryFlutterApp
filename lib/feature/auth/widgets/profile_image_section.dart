import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({
    super.key,
    required this.userModel,
    required this.selectedImage,
    required this.onUploadTap,
    required this.onDeleteTap,
  });

  final dynamic userModel;
  final String? selectedImage;
  final VoidCallback onUploadTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Upload button dan Delete button akan masuk ke sini
              // Untuk kesederhanaan, kami akan render di parent
            ],
          ),
        ),
      ],
    );
  }
}
