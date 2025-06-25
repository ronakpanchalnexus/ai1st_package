import 'package:bestforming_cac/core/usecases/usecases.dart';
import 'package:bestforming_cac/src/features/courses/domain/entity/course_list_entity.dart';
import 'package:bestforming_cac/src/features/courses/domain/repo/courses_repo.dart';
import 'package:bestforming_cac/src/shared/data_state.dart';

class CourseListUseCase
    extends FutureUsecaseWithoutParams<DataState<CourseListEntity>> {
  const CourseListUseCase(this._repo);

  final CoursesRepo _repo;

  @override
  Future<DataState<CourseListEntity>> call() => _repo.getCourseList();
}
