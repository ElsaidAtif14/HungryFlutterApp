import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/feature/auth/data/auth_repo.dart';
import 'package:hungry/feature/auth/view/signup_view.dart';
import 'package:hungry/feature/auth/widgets/custom_auth_button.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/custom_snack_bar.dart';
import 'package:hungry/shared/custom_text.dart';
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (c) {
                return Root();
              },
            ),
          );
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
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
                    Gap(120),
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      color: AppColors.primaryColor,
                    ),
                    Gap(8),
                    CustomText(
                      color: AppColors.primaryColor,
                      text: 'Welcome Back ,Discover the fast food',
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(60),

                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.primaryColor.withOpacity(0.4),
                      ),
                      child: Column(
                        children: [
                          Gap(30),
                          CustomTextField(
                            controller: emailController,
                            hint: 'Email Address',
                            isPassword: false,
                          ),
                          Gap(20),
                          CustomTextField(
                            controller: passController,
                            hint: 'Password ',
                            isPassword: true,
                          ),
                          Gap(30),
                          isloading
                              ? CupertinoActivityIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : CustomAuthButton(
                                  text: 'Login',
                                  color: AppColors.primaryColor,
                                  fontColor: Colors.white,
                                  onTap: login,
                                ),
                          Gap(20),
                          CustomAuthButton(
                            text: 'SignUp',
                            fontColor: Colors.black,
                            fontweight: FontWeight.bold,
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (c) {
                                    return SignupView();
                                  },
                                ),
                              );
                            },
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [

                          // CustomAuthButton(
                          //   onTap: () => Navigator.push(
                          //     context,
                          //     (MaterialPageRoute(builder: (_) => Root())),
                          //   ),
                          //   width: Size.width * 0.37,
                          //   fontweight: FontWeight.bold,
                          //   text: 'Guest',
                          //   fontColor: Colors.black,
                          // ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    Gap(145),
                    CustomText(
                      text: '@ john Snow 2019',
                      color: AppColors.primaryColor,
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(30),
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
