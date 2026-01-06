import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/core/utils/app_router.dart';
import 'package:hungry/core/utils/pref_helper.dart';

class Splach extends StatefulWidget {
  const Splach({super.key});

  @override
  State<Splach> createState() => _SplachState();
}

class _SplachState extends State<Splach> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeLogo;
  late Animation<Offset> _slideLogo;
  late Animation<double> _fadeImage;

  @override
  void initState() {
    super.initState();

    // ------ Animation setup ------
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeLogo = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideLogo = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeImage = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );

    // Start animation
    _controller.forward();

    // Navigate after 2 seconds
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await PrefHelper.getToken();

    if (mounted) {
      if (token == null) {
        GoRouter.of(context).pushReplacement(AppRouter.kLogin);
      } else {
        GoRouter.of(context).pushReplacement(AppRouter.kRoot);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            const Gap(250),

            // ---- LOGO WITH ANIMATION ----
            FadeTransition(
              opacity: _fadeLogo,
              child: SlideTransition(
                position: _slideLogo,
                child: SvgPicture.asset('assets/images/logo.svg'),
              ),
            ),

            const Spacer(),

            // ---- IMAGE WITH FADE ANIMATION ----
            FadeTransition(
              opacity: _fadeImage,
              child: Image.asset('assets/images/image_1.png'),
            ),
          ],
        ),
      ),
    );
  }
}
