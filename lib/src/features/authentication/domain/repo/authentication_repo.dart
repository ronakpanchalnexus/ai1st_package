import 'package:ai1st_package/src/features/authentication/domain/entity/forgot_password_entity.dart';
import 'package:ai1st_package/src/features/authentication/domain/entity/sign_in_entity.dart';
import 'package:ai1st_package/src/features/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:ai1st_package/src/shared/data_state.dart';

abstract class AuthenticationRepo {
  const AuthenticationRepo();

  Future<DataState<SignInEntity>> signIn({required SignInParams signInParams});

  Future<DataState<ForgotPasswordEntity>> forgotPassword(
      {required String email});
}
