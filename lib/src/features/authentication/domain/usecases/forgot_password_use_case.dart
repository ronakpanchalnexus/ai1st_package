import 'package:bestforming_cac/core/usecases/usecases.dart';
import 'package:bestforming_cac/src/features/authentication/domain/entity/forgot_password_entity.dart';
import 'package:bestforming_cac/src/features/authentication/domain/repo/authentication_repo.dart';
import 'package:bestforming_cac/src/shared/data_state.dart';

class ForgotPasswordUseCase
    extends FutureUsecaseWithParams<DataState<ForgotPasswordEntity>, String> {
  const ForgotPasswordUseCase(this._repo);

  final AuthenticationRepo _repo;

  @override
  Future<DataState<ForgotPasswordEntity>> call(String params) =>
      _repo.forgotPassword(email: params);
}
