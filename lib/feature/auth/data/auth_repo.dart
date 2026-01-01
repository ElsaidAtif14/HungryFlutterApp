import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import 'package:hungry/feature/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post('/login', {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];


        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
          }

        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Signup
  Future<UserModel?> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post('/register', {
        'name': name,
        'password': password,
        'email': email,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final coder = int.tryParse(code);
        final data = response['data'];

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        /// condtion assement
        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }

        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //get profiledata

  Future<UserModel?> getProfileData() async {
    try {
      final response = await apiService.get('/profile');
      final user = UserModel.fromJson(response['data']);
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// update profile data
  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'address': address,
        if (visa != null && visa.isNotEmpty) 'Visa': visa,
        if (imagePath != null && imagePath.isNotEmpty)
          'image': await MultipartFile.fromFile(
            imagePath,
            filename: 'profile.jpg',
          ),
      });

      final response = await apiService.post('/update-profile', formData);

      if (response is ApiError) throw response;

      final int code = response['code'];
      final String? msg = response['message'];
      final data = response['data'];

      if (code != 200 && code != 201) {
        throw ApiError(message: msg ?? 'Unknown error');
      }

      return UserModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //logout
  Future<void> logout() async {
    final response = await apiService.post('/logout', {});
    if (response['data'] != null) {
      throw ApiError(message: 'Some thing error');
    }
    await PrefHelper.clearToken();
  }
}
