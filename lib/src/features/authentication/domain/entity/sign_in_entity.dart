import 'package:ai1st_package/src/features/authentication/data/models/sign_in_model.dart';
import 'package:equatable/equatable.dart';

class SignInEntity extends Equatable {
  final String? code;
  final String? message;
  final SignInData? data;

  const SignInEntity({
    this.code,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [code, message, data];
}
