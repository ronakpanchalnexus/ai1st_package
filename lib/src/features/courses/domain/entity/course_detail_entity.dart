import 'package:bestforming_cac/src/features/courses/data/models/course_detail_model.dart';
import 'package:equatable/equatable.dart';

class CourseDetailEntity extends Equatable {
  final String? code;
  final String? message;
  final CourseDetailData? data;

  const CourseDetailEntity({
    this.code,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [code, message, data];
}
