import 'package:bestforming_cac/src/features/courses/data/datasources/courses_remote_data.dart';
import 'package:bestforming_cac/src/features/courses/data/models/course_detail_model.dart';
import 'package:bestforming_cac/src/features/courses/data/models/course_list_model.dart';
import 'package:bestforming_cac/src/features/courses/data/models/mark_topic_complete_model.dart';
import 'package:bestforming_cac/src/features/courses/data/models/video_library_model.dart';
import 'package:bestforming_cac/src/features/courses/domain/repo/courses_repo.dart';
import 'package:bestforming_cac/src/features/courses/domain/usecases/course_detail_use_case.dart';
import 'package:bestforming_cac/src/features/courses/domain/usecases/mark_topic_complete_use_case.dart';
import 'package:bestforming_cac/src/shared/data_state.dart';
import 'package:dio/dio.dart';

class CoursesRepoImplementation implements CoursesRepo {
  const CoursesRepoImplementation(this._remoteDataSource);

  final CoursesRemoteDataSource _remoteDataSource;

  @override
  Future<DataState<VideoLibraryModel>> getVideoLibrary() async {
    try {
      final result = await _remoteDataSource.getVideoLibrary();
      return result;
    } catch (e) {
      return DataFailed(
        DioException(requestOptions: RequestOptions(), message: e.toString()),
      );
    }
  }

  @override
  Future<DataState<CourseListModel>> getCourseList() async {
    try {
      final result = await _remoteDataSource.getCourseList();
      return result;
    } catch (e) {
      return DataFailed(
        DioException(requestOptions: RequestOptions(), message: e.toString()),
      );
    }
  }

  @override
  Future<DataState<CourseDetailModel>> getCourseDetail(CourseDetailParams params) async {
    try {
      final result = await _remoteDataSource.getCourseDetail(params);
      return result;
    } catch (e) {
      return DataFailed(
        DioException(requestOptions: RequestOptions(), message: e.toString()),
      );
    }
  }

  @override
  Future<DataState<MarkTopicCompleteModel>> markTopicComplete(MarkTopicCompleteParams markTopicCompleteParams) async {
    try {
      final result = await _remoteDataSource.markTopicComplete(markTopicCompleteParams);
      return result;
    } catch (e) {
      return DataFailed(
        DioException(requestOptions: RequestOptions(), message: e.toString()),
      );
    }
  }
}
