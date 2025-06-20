import 'package:equatable/equatable.dart';

class ForgotPasswordEntity extends Equatable {
  final int? code;
  final String? message;

  const ForgotPasswordEntity({
    this.code,
    this.message,
  });

  @override
  List<Object?> get props => [code, message];
}
