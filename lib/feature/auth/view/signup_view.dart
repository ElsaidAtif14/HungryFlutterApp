import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/feature/auth/data/auth_repo.dart';
import 'package:hungry/feature/auth/view/login_view.dart';
import 'package:hungry/feature/auth/widgets/custom_auth_button.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/custom_snack_bar.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepo authRepo = AuthRepo();

  bool isLoading = false;

  Future<void> signup() async {
    setState(() => isLoading = true);

    if (formKey.currentState!.validate()) {
      try {
        await authRepo.signup(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Root()),
        );
      } catch (e) {
        String msg = 'Unhandled error';
        if (e is ApiError) msg = e.message;
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(msg));
      }
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    const Gap(120),
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      color: AppColors.primaryColor,
                    ),
                    const Gap(8),
                    const CustomText(
                      text: 'Welcome To our Food App',
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                    const Gap(60),

                    /// 🔹 Card
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.primaryColor.withOpacity(0.4),
                      ),
                      child: Column(
                        children: [
                          const Gap(30),
                          CustomTextField(
                            controller: nameController,
                            hint: 'Name',
                            isPassword: false,
                          ),
                          const Gap(20),
                          CustomTextField(
                            controller: emailController,
                            hint: 'Email Address',
                            isPassword: false,
                          ),
                          const Gap(20),
                          CustomTextField(
                            controller: passController,
                            hint: 'Password',
                            isPassword: true,
                          ),
                          const Gap(30),

                          isLoading
                              ? const CupertinoActivityIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : CustomAuthButton(
                                  text: 'Sign Up',
                                  color: AppColors.primaryColor,
                                  fontColor: Colors.white,
                                  onTap: signup,
                                ),
                          const Gap(20),
                          CustomAuthButton(
                            text: 'Login',
                            fontColor: Colors.black,
                            fontweight: FontWeight.bold,
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginView(),
                                ),
                              );
                            },
                          ),
                          // /// 🔹 Actions
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [

                          //     const Gap(18),
                          //     CustomAuthButton(
                          //       width: size.width * 0.37,
                          //       text: 'Guest',
                          //       fontColor: Colors.black,
                          //       fontweight: FontWeight.bold,
                          //       onTap: () {
                          //         Navigator.pushReplacement(
                          //           context,
                          //           MaterialPageRoute(builder: (_) => Root()),
                          //         );
                          //       },
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),

                    const Gap(140),
                    const CustomText(
                      text: '@ john Snow 2019',
                      size: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                    const Gap(30),
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
