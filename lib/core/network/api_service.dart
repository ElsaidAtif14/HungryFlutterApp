import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  /// CRUD METHODS

  /// get
  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// post
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// put || update
  Future<dynamic> put(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }
/// delete
Future<dynamic> delete(String endPoint) async {
  try {
    final response = await _dioClient.dio.delete(endPoint);
    return response.data;
  } on DioException catch (e) {
    throw ApiExceptions.handleError(e);
  }
}
}