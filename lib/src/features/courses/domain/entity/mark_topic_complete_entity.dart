import 'package:equatable/equatable.dart';

class MarkTopicCompleteEntity extends Equatable {
  final String? code;
  final String? message;

  const MarkTopicCompleteEntity({
    this.code,
    this.message,
  });

  @override
  List<Object?> get props => [code, message];
}
