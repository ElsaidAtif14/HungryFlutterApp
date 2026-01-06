import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/feature/auth/data/user_model.dart';
import 'package:hungry/feature/home/widgets/search_field.dart';
import 'package:hungry/feature/home/widgets/user_header.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.userModel,
    required this.searchController,
    required this.onSearchChanged,
  });

  final UserModel? userModel;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(75),
        UserHeader(userModel: userModel),
        const Gap(25),
        SearchField(
          controller: searchController,
          onChanged: onSearchChanged,
        ),
      ],
    );
  }
}
