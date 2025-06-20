import 'package:ai1st_package/src/features/authentication/data/models/forgot_password_model.dart';
import 'package:dio/dio.dart';
import 'package:ai1st_package/src/features/authentication/data/datasources/authentication_remote_data.dart';
import 'package:ai1st_package/src/features/authentication/data/models/sign_in_model.dart';
import 'package:ai1st_package/src/features/authentication/domain/repo/authentication_repo.dart';
import 'package:ai1st_package/src/features/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:ai1st_package/src/shared/data_state.dart';

class AuthenticationRepoImplementation implements AuthenticationRepo {
  const AuthenticationRepoImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  Future<DataState<SignInModel>> signIn({
    required SignInParams signInParams,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(signInParams: signInParams);
      return result;
    } catch (e) {
      return DataFailed(
        DioException(requestOptions: RequestOptions(), message: e.toString()),
      );
    }
  }

  @override
  Future<DataState<ForgotPasswordModel>> forgotPassword({
    required String email,
  }) async {
    try {
      final result = await _remoteDataSource.forgotPassword(email: email);
      return result;
    } catch (e) {
      return DataFailed(
        DioException(requestOptions: RequestOptions(), message: e.toString()),
      );
    }
  }
}
