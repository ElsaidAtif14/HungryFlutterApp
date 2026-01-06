import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/utils/app_router.dart';
import 'package:hungry/feature/auth/data/auth_repo.dart';
import 'package:hungry/feature/auth/widgets/auth_footer.dart';
import 'package:hungry/feature/auth/widgets/auth_form_card.dart';
import 'package:hungry/feature/auth/widgets/auth_header.dart';
import 'package:hungry/feature/auth/widgets/custom_auth_button.dart';
import 'package:hungry/shared/custom_snack_bar.dart';
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

        GoRouter.of(context).pushReplacement(AppRouter.kRoot);
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        child: AbsorbPointer(
          absorbing: isLoading,
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
                      AuthHeader(
                        title: 'Welcome To our Food App',
                      ),
                      AuthFormCard(
                        children: [
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
                          const Gap(20),
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
                              GoRouter.of(context).push(AppRouter.kLogin);
                            },
                          ),
                        ],
                      ),
                      const AuthFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
