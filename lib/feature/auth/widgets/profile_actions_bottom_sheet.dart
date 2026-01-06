import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class ProfileActionsBottomSheet extends StatelessWidget {
  const ProfileActionsBottomSheet({
    super.key,
    required this.isLoadingUpdate,
    required this.isLogout,
    required this.onEdit,
    required this.onLogout,
  });

  final bool isLoadingUpdate;
  final bool isLogout;
  final VoidCallback onEdit;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],

      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: onEdit,
              child: isLoadingUpdate
                  ? const CupertinoActivityIndicator()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryColor,
                      ),
                      child: Row(
                        children: [
                          const CustomText(
                            text: 'Edit Profile',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          const Gap(5),
                          const Icon(
                            CupertinoIcons.pencil,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
            ),
            GestureDetector(
              onTap: onLogout,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: isLogout
                    ? const CupertinoActivityIndicator()
                    : const Row(
                        children: [
                          CustomText(
                            text: 'Log Out',
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                          Gap(5),
                          Icon(
                            Icons.logout,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

