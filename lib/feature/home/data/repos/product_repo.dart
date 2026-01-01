import 'package:flutter/material.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/feature/home/data/model/product_model.dart';
import 'package:hungry/feature/home/data/model/side_options.dart';
import 'package:hungry/feature/home/data/model/topping_model.dart';

class ProductRepo {
  final ApiService _apiService = ApiService();

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _apiService.get('/products/');
      return (response['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<ToppingModel>> getToppings() async {
    try {
      final response = await _apiService.get('/toppings/');
      return (response['data'] as List)
          .map((e) => ToppingModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<SideOptionModel>> getSideOptions() async {
    try {
      final response = await _apiService.get('/side-options/');
      return (response['data'] as List)
          .map((e) => SideOptionModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}