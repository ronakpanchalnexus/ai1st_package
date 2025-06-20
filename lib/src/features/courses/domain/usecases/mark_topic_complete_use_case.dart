import 'package:ai1st_package/core/usecases/usecases.dart';
import 'package:ai1st_package/src/features/courses/domain/entity/mark_topic_complete_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/repo/courses_repo.dart';
import 'package:ai1st_package/src/shared/data_state.dart';
import 'package:equatable/equatable.dart';

class MarkTopicCompleteUseCase extends FutureUsecaseWithParams<
    DataState<MarkTopicCompleteEntity>, MarkTopicCompleteParams> {
  const MarkTopicCompleteUseCase(this._repo);

  final CoursesRepo _repo;

  @override
  Future<DataState<MarkTopicCompleteEntity>> call(
          MarkTopicCompleteParams params) =>
      _repo.markTopicComplete(params);
}

class MarkTopicCompleteParams extends Equatable {
  const MarkTopicCompleteParams(
      {required this.courseId, required this.topicId});

  const MarkTopicCompleteParams.empty()
      : courseId = '',
        topicId = '';

  final String courseId;
  final String topicId;

  @override
  List<String> get props => [courseId, topicId];
}
