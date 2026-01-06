import 'package:go_router/go_router.dart';
import 'package:hungry/feature/auth/view/login_view.dart';
import 'package:hungry/feature/auth/view/signup_view.dart';
import 'package:hungry/feature/auth/view/profile_view.dart';
import 'package:hungry/feature/cart/view/cart_view.dart';
import 'package:hungry/feature/checkout/view/check_out_view.dart';
import 'package:hungry/feature/home/view/home_view.dart';
import 'package:hungry/feature/orderHistory/view/order_history_view.dart';
import 'package:hungry/feature/product/view/product_details_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/splach.dart';

abstract class AppRouter {
  static const kSplash = '/';
  static const kRoot = '/root';
  static const kHome = 'home';
  static const kLogin = '/login';
  static const kSignup = '/signup';
  static const kProductDetails = '/product-details';
  static const kCart = '/cart';
  static const kCheckout = '/checkout';
  static const kOrderHistory = '/order-history';
  static const kProfile = '/profile';

  static final router = GoRouter(
    initialLocation: kSplash,
    routes: [
      GoRoute(
        path: kSplash,
        builder: (context, state) => const Splach(),
      ),
      GoRoute(
        path: kRoot,
        builder: (context, state) => const Root(),
        routes: [
          GoRoute(
            path: kHome,
            builder: (context, state) => const HomeView(),
          ),
          GoRoute(
            path: kProductDetails,
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>;
              return ProductDetailsView(
                productId: data['productId'] as int,
                productImage: data['productImage'] as String,
                productName: data['productName'] as String,
                productPrice: data['productPrice'] as String,
              );
            },
          ),
          GoRoute(
            path: kCart,
            builder: (context, state) => const CartView(),
          ),
          GoRoute(
            path: kCheckout,
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>?;
              return CheckOutView(
                totalPrice: data?['totalPrice'] ?? '0.00',
                cartResponseModel: data?['cartResponseModel'],
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: kLogin,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: kSignup,
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: kOrderHistory,
        builder: (context, state) => const OrderHistoryView(),
      ),
      GoRoute(
        path: kProfile,
        builder: (context, state) => const ProfileView(),
      ),
    ],
  );
}
