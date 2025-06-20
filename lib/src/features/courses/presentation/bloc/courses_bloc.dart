import 'package:ai1st_package/src/features/courses/domain/entity/course_detail_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/entity/course_list_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/entity/mark_topic_complete_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/entity/video_library_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/usecases/course_detail_use_case.dart';
import 'package:ai1st_package/src/features/courses/domain/usecases/course_list_use_case.dart';
import 'package:ai1st_package/src/features/courses/domain/usecases/mark_topic_complete_use_case.dart';
import 'package:ai1st_package/src/features/courses/domain/usecases/video_library_use_case.dart';
import 'package:ai1st_package/src/shared/data_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc({
    required VideoLibraryUseCase videoLibraryUseCase,
    required CourseListUseCase courseListUseCase,
    required CourseDetailUseCase courseDetailUseCase,
    required MarkTopicCompleteUseCase markTopicCompleteUseCase,
  })  : _videoLibraryUseCase = videoLibraryUseCase,
        _courseListUseCase = courseListUseCase,
        _courseDetailUseCase = courseDetailUseCase,
        _markTopicCompleteUseCase = markTopicCompleteUseCase,
        super(const CoursesInitial()) {
    on<VideoLibraryEvent>(_onGetVideoLibrary);
    on<CourseListEvent>(_onGetCourseList);
    on<CourseDetailEvent>(_onGetCourseDetail);
    on<MarkTopicCompleteEvent>(_onMarkTopicComplete);
  }

  final VideoLibraryUseCase _videoLibraryUseCase;
  final CourseListUseCase _courseListUseCase;
  final CourseDetailUseCase _courseDetailUseCase;
  final MarkTopicCompleteUseCase _markTopicCompleteUseCase;

  Future<void> _onGetVideoLibrary(
    VideoLibraryEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());

    final result = await _videoLibraryUseCase.call();

    if (result is DataSuccess && result.data != null) {
      emit(VideoLibraryStateSuccess(result.data!));
    }

    if (result is DataFailed) {
      emit(VideoLibraryStateFailed(result.error!));
    }
  }

  Future<void> _onGetCourseList(
    CourseListEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());

    final result = await _courseListUseCase.call();

    if (result is DataSuccess && result.data != null) {
      emit(CourseListStateSuccess(result.data!));
    }

    if (result is DataFailed) {
      emit(CourseListStateFailed(result.error!));
    }
  }

  Future<void> _onGetCourseDetail(
    CourseDetailEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());

    final result = await _courseDetailUseCase.call(event.params);

    if (result is DataSuccess && result.data != null) {
      emit(CourseDetailStateSuccess(result.data!));
    }

    if (result is DataFailed) {
      emit(CourseDetailStateFailed(result.error!));
    }
  }

  Future<void> _onMarkTopicComplete(
    MarkTopicCompleteEvent event,
    Emitter<CoursesState> emit,
  ) async {
    final result =
        await _markTopicCompleteUseCase.call(event.markTopicCompleteParams);

    if (result is DataSuccess && result.data != null) {
      emit(MarkTopicCompleteStateSuccess(result.data!, DateTime.now()));
    }

    if (result is DataFailed) {
      emit(MarkTopicCompleteStateFailed(result.error!));
    }
  }
}
