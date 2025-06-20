part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

final class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

final class SignedInStateSuccess extends AuthenticationState {
  const SignedInStateSuccess(this.loginEntity);

  final SignInEntity loginEntity;

  @override
  List<Object> get props => [loginEntity];
}

final class SignedInStateFailed extends AuthenticationState {
  const SignedInStateFailed(this.dioException);

  final DioException dioException;

  @override
  List<Object> get props => [dioException];
}

final class ForgotPasswordStateSuccess extends AuthenticationState {
  const ForgotPasswordStateSuccess(this.forgotPasswordEntity);

  final ForgotPasswordEntity forgotPasswordEntity;

  @override
  List<Object> get props => [forgotPasswordEntity];
}

final class ForgotPasswordStateFailed extends AuthenticationState {
  const ForgotPasswordStateFailed(this.dioException);

  final DioException dioException;

  @override
  List<Object> get props => [dioException];
}

final class TogglePasswordState extends AuthenticationState {
  const TogglePasswordState(this.togglePassword);

  final bool togglePassword;

  @override
  List<Object> get props => [togglePassword];
}
