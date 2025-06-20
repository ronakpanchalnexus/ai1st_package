import 'package:ai1st_package/core/usecases/usecases.dart';
import 'package:ai1st_package/src/features/courses/domain/entity/course_detail_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/repo/courses_repo.dart';
import 'package:ai1st_package/src/shared/data_state.dart';
import 'package:equatable/equatable.dart';

class CourseDetailUseCase extends FutureUsecaseWithParams<
    DataState<CourseDetailEntity>, CourseDetailParams> {
  const CourseDetailUseCase(this._repo);

  final CoursesRepo _repo;

  @override
  Future<DataState<CourseDetailEntity>> call(CourseDetailParams params) =>
      _repo.getCourseDetail(params);
}

class CourseDetailParams extends Equatable {
  const CourseDetailParams({required this.id, required this.isEnroll});

  const CourseDetailParams.empty()
      : id = '',
        isEnroll = false;

  final String id;
  final bool isEnroll;

  @override
  List<dynamic> get props => [id, isEnroll];
}
