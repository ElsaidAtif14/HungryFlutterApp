import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/feature/cart/data/cart_model.dart';
import 'package:hungry/feature/orderHistory/data/order_history_model.dart';

class OrderHistoryRepo {
  
  final ApiService _apiService = ApiService();

   Future<void> addToOrder(CartRequestModel cartData) async {

    try {
      final res = await _apiService.post('/orders', cartData.toJson());

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

  /// ✅ جلب Order History
  Future<List<OrderHistoryModel>> getOrderHistory() async {
    try {
      final res = await _apiService.get('/orders');

      if (res is Map<String, dynamic>) {
        final data = res['data'] as List<dynamic>?;

        if (data == null) return [];

        return data
            .map((e) => OrderHistoryModel.fromJson(e))
            .toList();
      } else {
        throw ApiError(message: 'Unexpected response from server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}