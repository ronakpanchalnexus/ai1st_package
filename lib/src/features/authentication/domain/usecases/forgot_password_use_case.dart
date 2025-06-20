import 'package:ai1st_package/core/usecases/usecases.dart';
import 'package:ai1st_package/src/features/authentication/domain/entity/forgot_password_entity.dart';
import 'package:ai1st_package/src/features/authentication/domain/repo/authentication_repo.dart';
import 'package:ai1st_package/src/shared/data_state.dart';

class ForgotPasswordUseCase
    extends FutureUsecaseWithParams<DataState<ForgotPasswordEntity>, String> {
  const ForgotPasswordUseCase(this._repo);

  final AuthenticationRepo _repo;

  @override
  Future<DataState<ForgotPasswordEntity>> call(String params) =>
      _repo.forgotPassword(email: params);
}
