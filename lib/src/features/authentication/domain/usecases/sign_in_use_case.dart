import 'package:equatable/equatable.dart';
import 'package:bestforming_cac/core/usecases/usecases.dart';
import 'package:bestforming_cac/src/features/authentication/domain/entity/sign_in_entity.dart';
import 'package:bestforming_cac/src/features/authentication/domain/repo/authentication_repo.dart';
import 'package:bestforming_cac/src/shared/data_state.dart';

class SignInUseCase
    extends FutureUsecaseWithParams<DataState<SignInEntity>, SignInParams> {
  const SignInUseCase(this._repo);

  final AuthenticationRepo _repo;

  @override
  Future<DataState<SignInEntity>> call(SignInParams params) =>
      _repo.signIn(signInParams: params);
}

class SignInParams extends Equatable {
  const SignInParams({required this.username, required this.password});

  const SignInParams.empty() : username = '', password = '';

  final String username;
  final String password;

  @override
  List<String> get props => [username, password];
}
