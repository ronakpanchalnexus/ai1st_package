import 'package:bestforming_cac/src/features/courses/data/models/course_list_model.dart';
import 'package:equatable/equatable.dart';

class CourseListEntity extends Equatable {
  final String? code;
  final String? message;
  final CourseListData? data;

  const CourseListEntity({
    this.code,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [code, message, data];
}
