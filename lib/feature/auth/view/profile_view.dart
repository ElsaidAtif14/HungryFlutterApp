import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/feature/auth/widgets/custom_auth_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:hungry/feature/auth/data/auth_repo.dart';
import 'package:hungry/feature/auth/data/user_model.dart';
import 'package:hungry/feature/auth/view/login_view.dart';
import 'package:hungry/feature/auth/widgets/custom_user_text_field.dart';
import 'package:hungry/shared/custom_snack_bar.dart';
import 'package:hungry/shared/custom_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();
  bool isLoadingUpdate = false;
  final AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  String? selectedImage;
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
        _name.text = userModel?.name ?? '';
        _email.text = userModel?.email ?? '';
        _address.text = userModel?.address ?? '';
      });
    } catch (e) {
      String errmsg = 'Error In profile';
      if (e is ApiError) {
        errmsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errmsg));
    }
  }

  Future<void> updateProfileData() async {
    try {
      setState(() => isLoadingUpdate = true);

      await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        visa: _visa.text.trim(),
        imagePath: selectedImage,
      );

      await getProfileData(); // ✅ مهم

      setState(() => isLoadingUpdate = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar('Profile Updated Successfully'));
    } catch (e) {
      setState(() => isLoadingUpdate = false);
      String errmsg = 'Failed to Update Profile';
      if (e is ApiError) errmsg = e.message;
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errmsg));
    }
  }

  String hiddenVisaNumber() {
    String visaNumber = userModel?.visa ?? '';

    String lastFour = visaNumber.substring(visaNumber.length - 4);
    String hiddenNumber = '*' * (visaNumber.length - 4);
    return '$hiddenNumber$lastFour';
  }

  Future<void> logout() async {
    await authRepo.logout();
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) {
          return LoginView();
        },
      ),
    );
  }

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.primaryColor,
      color: Colors.white,
      onRefresh: getProfileData,

      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Skeletonizer(
          enabled: userModel == null,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0,
              elevation: 0,
              toolbarHeight: 25,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.arrow_back),
                        Icon(CupertinoIcons.settings, size: 26),
                      ],
                    ),
                    userModel == null
                        ? const CupertinoActivityIndicator()
                        : Center(
                            child: Container(
                              height: 120,
                              width: 120,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                border: Border.all(
                                  width: 2,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              child: selectedImage != null
                                  ? Image.file(
                                      File(selectedImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : (userModel?.image != null &&
                                        userModel!.image!.isNotEmpty)
                                  ? Image.network(
                                      '${userModel!.image!}?v=${DateTime.now().millisecondsSinceEpoch}',
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.person),
                                    )
                                  : Icon(Icons.person),
                            ),
                          ),
                    const Gap(10),
                    CustomAuthButton(
                      width: 140,
                      height: 45,
                      radius: 20,
                      text: 'Upload image',
                      fontColor: Colors.white,
                      color: AppColors.primaryColor,
                      onTap: pickImage,
                    ),
                    const Gap(30),
                    CustomUserTextField(controller: _name, label: 'Name'),
                    const Gap(20),
                    CustomUserTextField(controller: _email, label: 'Email'),
                    const Gap(20),
                    CustomUserTextField(controller: _address, label: 'Address'),
                    const Gap(20),
                    const Divider(),
                    const Gap(10),
                    userModel?.visa == null
                        ? CustomUserTextField(
                            textInputType:
                                const TextInputType.numberWithOptions(),
                            controller: _visa,
                            label: 'Add Visa Card',
                          )
                        : ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            tileColor: const Color.fromARGB(
                              255,
                              155,
                              139,
                              96,
                            ).withOpacity(0.6),
                            leading: Image.asset(
                              'assets/images/icons/profileVisa.png',
                              width: 50,
                            ),
                            title: const CustomText(
                              text: 'Debit card',
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            subtitle: CustomText(
                              text: hiddenVisaNumber(),
                              color: Colors.black,
                            ),
                            trailing: const CustomText(
                              text: 'Defult',
                              color: Colors.black,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: updateProfileData,
                      child: isLoadingUpdate
                          ? CupertinoActivityIndicator()
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
                      onTap: logout,
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
                        child: Row(
                          children: const [
                            CustomText(
                              text: 'Log Out',
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                            Gap(5),
                            Icon(Icons.logout, color: AppColors.primaryColor),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
