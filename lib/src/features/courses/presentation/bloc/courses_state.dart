part of 'courses_bloc.dart';

sealed class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object?> get props => [];
}

final class CoursesInitial extends CoursesState {
  const CoursesInitial();
}

final class CoursesLoading extends CoursesState {
  const CoursesLoading();
}

final class VideoLibraryStateSuccess extends CoursesState {
  const VideoLibraryStateSuccess(this.videoLibraryEntity);

  final VideoLibraryEntity videoLibraryEntity;

  @override
  List<Object> get props => [videoLibraryEntity];
}

final class VideoLibraryStateFailed extends CoursesState {
  const VideoLibraryStateFailed(this.dioException);

  final DioException dioException;

  @override
  List<Object> get props => [dioException];
}

final class CourseListStateSuccess extends CoursesState {
  const CourseListStateSuccess(this.courseListEntity);

  final CourseListEntity courseListEntity;

  @override
  List<Object> get props => [courseListEntity];
}

final class CourseListStateFailed extends CoursesState {
  const CourseListStateFailed(this.dioException);

  final DioException dioException;

  @override
  List<Object> get props => [dioException];
}

final class CourseDetailStateSuccess extends CoursesState {
  const CourseDetailStateSuccess(this.courseDetailEntity);

  final CourseDetailEntity courseDetailEntity;

  @override
  List<Object> get props => [courseDetailEntity];
}

final class CourseDetailStateFailed extends CoursesState {
  const CourseDetailStateFailed(this.dioException);

  final DioException dioException;

  @override
  List<Object> get props => [dioException];
}

final class MarkTopicCompleteStateSuccess extends CoursesState {
  const MarkTopicCompleteStateSuccess(
    this.markTopicCompleteEntity,
    this.timestamp,
  );

  final MarkTopicCompleteEntity markTopicCompleteEntity;
  final DateTime timestamp; // 👈 this makes each state unique

  @override
  List<Object> get props => [markTopicCompleteEntity, timestamp];
}

final class MarkTopicCompleteStateFailed extends CoursesState {
  const MarkTopicCompleteStateFailed(this.dioException);

  final DioException dioException;

  @override
  List<Object> get props => [dioException];
}
