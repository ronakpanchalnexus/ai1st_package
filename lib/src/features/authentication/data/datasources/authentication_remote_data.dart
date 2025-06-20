import 'dart:convert';

import 'package:ai1st_package/core/api/api_constant.dart';
import 'package:ai1st_package/core/api/api_service.dart';
import 'package:ai1st_package/core/constants/strings.dart';
import 'package:ai1st_package/core/helper/utils.dart';
import 'package:ai1st_package/src/features/authentication/data/models/forgot_password_model.dart';
import 'package:ai1st_package/src/features/authentication/data/models/sign_in_model.dart';
import 'package:ai1st_package/src/features/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:ai1st_package/src/shared/data_state.dart';
import 'package:dio/dio.dart';

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource();

  Future<DataState<SignInModel>> signIn({required SignInParams signInParams});

  Future<DataState<ForgotPasswordModel>> forgotPassword(
      {required String email});
}

class AuthenticationRemoteDataSourceImplementation
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImplementation({required Dio dio})
      : _dio = dio;

  final Dio _dio;

  @override
  Future<DataState<SignInModel>> signIn({
    required SignInParams signInParams,
  }) async {
    try {
      if (await Utils.checkInternet()) {
        final value = await ApiService(_dio).postData(
          headerType: 1,
          url: ApiConstant.login,
          body: {
            ApiConstant.username: signInParams.username,
            ApiConstant.password: signInParams.password,
          },
        );

        Utils.log('response -> $value');
        SignInModel it = SignInModel.fromJson(json.decode(value));
        if (it.code == '200') {
          return DataSuccess(it);
        } else {
          return DataFailed(
            DioException(
              requestOptions: RequestOptions(),
              message: it.message,
            ),
          );
        }
      } else {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(),
            message: Strings.internetConnectionMessage,
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DataState<ForgotPasswordModel>> forgotPassword({
    required String email,
  }) async {
    try {
      if (await Utils.checkInternet()) {
        final value = await ApiService(_dio).postData(
          headerType: 1,
          url: ApiConstant.forgotPassword,
          body: {
            ApiConstant.email: email,
          },
        );

        Utils.log('response -> $value');
        ForgotPasswordModel it =
            ForgotPasswordModel.fromJson(json.decode(value));
        if (it.code == 200) {
          return DataSuccess(it);
        } else {
          return DataFailed(
            DioException(
              requestOptions: RequestOptions(),
              message: it.message,
            ),
          );
        }
      } else {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(),
            message: Strings.internetConnectionMessage,
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
