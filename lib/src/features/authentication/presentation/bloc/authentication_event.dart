part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class SignInEvent extends AuthenticationEvent {
  const SignInEvent({required this.signInParams});

  final SignInParams signInParams;

  @override
  List<Object?> get props => [signInParams];
}

class ForgotPasswordEvent extends AuthenticationEvent {
  const ForgotPasswordEvent({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class TogglePasswordEvent extends AuthenticationEvent {
  const TogglePasswordEvent();

  @override
  List<Object?> get props => [];
}
