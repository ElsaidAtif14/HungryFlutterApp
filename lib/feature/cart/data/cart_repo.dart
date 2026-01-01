import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/feature/cart/data/cart_model.dart';

class CartRepo {
  final ApiService _apiService = ApiService();

  /// إضافة منتجات للكارت
  Future<void> addToCart(CartRequestModel cartData) async {
    try {
      final res = await _apiService.post('/cart/add', cartData.toJson());

      if (res is Map<String, dynamic>) {
        final code = res['code'];
        final msg = res['message'];

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? 'Failed to add to cart');
        }
      } else {
        throw ApiError(message: 'Unexpected response from server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<CartResponseModel> getCartResponse() async {
    try {
      final res = await _apiService.get('/cart');

      if (res is Map<String, dynamic>) {
        // تحويل الـ JSON كله إلى CartResponse
        final cartResponse = CartResponseModel.fromJson(res);
        return cartResponse;
      } else {
        throw ApiError(message: 'Unexpected response from server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // /// تحديث كمية منتج معين
  // Future<void> updateCartItem(int productId, int quantity) async {
  //   try {
  //     final res = await _apiService.post('/cart/update', {
  //       'product_id': productId,
  //       'quantity': quantity,
  //     });

  //     if (res is Map<String, dynamic>) {
  //       final code = res['code'];
  //       final msg = res['message'];

  //       if (code != 200 && code != 201) {
  //         throw ApiError(message: msg ?? 'Failed to update cart item');
  //       }
  //     } else {
  //       throw ApiError(message: 'Unexpected response from server');
  //     }
  //   } catch (e) {
  //     throw ApiError(message: e.toString());
  //   }
  // }

  /// حذف منتج من الكارت
  /// حذف منتج من الكارت
  Future<void> removeCartItem(int productId) async {
    try {
      final res = await _apiService.delete('/cart/remove/$productId');

      if (res is! Map<String, dynamic>) {
        throw ApiError(message: 'Unexpected response from server');
      }

      final code = res['code'];
      final msg = res['message'];

      if (code != 200 && code != 201) {
        throw ApiError(message: msg ?? 'Failed to remove cart item');
      }
    } catch (e) {
      rethrow;
    }
  }
 /// مسح كل عناصر الكارت بأمان
  Future<void> clearCart(List<CartItemModel> items) async {
    for (var item in items) {
      try {
        await removeCartItem(item.itemId); // حاول تمسح العنصر
      } catch (_) {
        // تجاهل أي error زي "item not found"
      }
    }
  }
}
