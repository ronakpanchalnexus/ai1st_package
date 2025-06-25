import 'package:bestforming_cac/src/features/authentication/domain/entity/forgot_password_entity.dart';
import 'package:bestforming_cac/src/features/authentication/domain/entity/sign_in_entity.dart';
import 'package:bestforming_cac/src/features/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:bestforming_cac/src/shared/data_state.dart';

abstract class AuthenticationRepo {
  const AuthenticationRepo();

  Future<DataState<SignInEntity>> signIn({required SignInParams signInParams});

  Future<DataState<ForgotPasswordEntity>> forgotPassword(
      {required String email});
}
