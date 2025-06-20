import 'package:ai1st_package/core/usecases/usecases.dart';
import 'package:ai1st_package/src/features/courses/domain/entity/course_list_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/repo/courses_repo.dart';
import 'package:ai1st_package/src/shared/data_state.dart';

class CourseListUseCase
    extends FutureUsecaseWithoutParams<DataState<CourseListEntity>> {
  const CourseListUseCase(this._repo);

  final CoursesRepo _repo;

  @override
  Future<DataState<CourseListEntity>> call() => _repo.getCourseList();
}
