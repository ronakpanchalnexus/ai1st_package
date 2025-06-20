part of 'courses_bloc.dart';

sealed class CoursesEvent extends Equatable {
  const CoursesEvent();
}

class VideoLibraryEvent extends CoursesEvent {
  const VideoLibraryEvent();

  @override
  List<Object?> get props => [];
}

class CourseListEvent extends CoursesEvent {
  const CourseListEvent();

  @override
  List<Object?> get props => [];
}

class CourseDetailEvent extends CoursesEvent {
  const CourseDetailEvent({required this.params});

  final CourseDetailParams params;

  @override
  List<Object?> get props => [params];
}

class MarkTopicCompleteEvent extends CoursesEvent {
  const MarkTopicCompleteEvent({required this.markTopicCompleteParams});

  final MarkTopicCompleteParams markTopicCompleteParams;

  @override
  List<Object?> get props => [markTopicCompleteParams];
}
