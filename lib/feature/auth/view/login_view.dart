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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isloading = false;

  AuthRepo authRepo = AuthRepo();
  Future<void> login() async {
    setState(() {
      isloading = true;
    });
    if (formKey.currentState!.validate()) {
      try {
        final user = await authRepo.login(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );
        if (user != null) {
          GoRouter.of(context).pushReplacement(AppRouter.kRoot);
        }
      } catch (e) {
        String errorMsg = 'Un Hundeld Error';
        if (e is ApiError) {
          errorMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMsg));
        debugPrint(errorMsg);
      }
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    emailController.text = 'elsaidatif@gmail.com';
    passController.text = '123456789';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        child: AbsorbPointer(
          absorbing: isloading,
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
                        title: 'Welcome Back ,Discover the fast food',
                      ),
                      AuthFormCard(
                        children: [
                          CustomTextField(
                            controller: emailController,
                            hint: 'Email Address',
                            isPassword: false,
                          ),
                          const Gap(20),
                          CustomTextField(
                            controller: passController,
                            hint: 'Password ',
                            isPassword: true,
                          ),
                          const Gap(20),
                          isloading
                              ? const CupertinoActivityIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : CustomAuthButton(
                                  text: 'Login',
                                  color: AppColors.primaryColor,
                                  fontColor: Colors.white,
                                  onTap: login,
                                ),
                          const Gap(20),
                          CustomAuthButton(
                            text: 'SignUp',
                            fontColor: Colors.black,
                            fontweight: FontWeight.bold,
                            onTap: () {
                              GoRouter.of(context).push(AppRouter.kSignup);
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
