import 'dart:convert';

import 'package:bestforming_cac/core/api/api_constant.dart';
import 'package:bestforming_cac/core/api/api_service.dart';
import 'package:bestforming_cac/core/constants/constants.dart';
import 'package:bestforming_cac/core/constants/strings.dart';
import 'package:bestforming_cac/core/helper/prefs.dart';
import 'package:bestforming_cac/core/helper/utils.dart';
import 'package:bestforming_cac/src/features/courses/data/models/course_detail_model.dart';
import 'package:bestforming_cac/src/features/courses/data/models/course_list_model.dart';
import 'package:bestforming_cac/src/features/courses/data/models/mark_topic_complete_model.dart';
import 'package:bestforming_cac/src/features/courses/data/models/video_library_model.dart';
import 'package:bestforming_cac/src/features/courses/domain/usecases/course_detail_use_case.dart';
import 'package:bestforming_cac/src/features/courses/domain/usecases/mark_topic_complete_use_case.dart';
import 'package:bestforming_cac/src/shared/data_state.dart';
import 'package:dio/dio.dart';

abstract class CoursesRemoteDataSource {
  const CoursesRemoteDataSource();

  Future<DataState<VideoLibraryModel>> getVideoLibrary();

  Future<DataState<CourseListModel>> getCourseList();

  Future<DataState<CourseDetailModel>> getCourseDetail(
      CourseDetailParams params);

  Future<DataState<MarkTopicCompleteModel>> markTopicComplete(
      MarkTopicCompleteParams markTopicCompleteParams);
}

class CoursesRemoteDataSourceImplementation implements CoursesRemoteDataSource {
  const CoursesRemoteDataSourceImplementation({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<DataState<VideoLibraryModel>> getVideoLibrary() async {
    try {
      if (await Utils.checkInternet()) {
        final value = await ApiService(_dio).getData(
          headerType: 2,
          url: ApiConstant.videoLibrary,
        );

        Utils.log('response -> $value');
        VideoLibraryModel it = VideoLibraryModel.fromJson(json.decode(value));
        if (it.code == '200') {
          return DataSuccess(it);
        } else {
          return DataFailed(
            DioException(
              requestOptions: RequestOptions(),
              message: it.message,
            ),
          );
        }
      } else {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(),
            message: Strings.internetConnectionMessage,
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DataState<CourseListModel>> getCourseList() async {
    try {
      if (await Utils.checkInternet()) {
        final value = await ApiService(_dio).getData(
          headerType: 2,
          url: ApiConstant.getCourses,
        );

        Utils.log('response -> $value');
        CourseListModel it = CourseListModel.fromJson(json.decode(value));
        if (it.code == '200') {
          return DataSuccess(it);
        } else {
          return DataFailed(
            DioException(
              requestOptions: RequestOptions(),
              message: it.message,
            ),
          );
        }
      } else {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(),
            message: Strings.internetConnectionMessage,
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DataState<CourseDetailModel>> getCourseDetail(
      CourseDetailParams params) async {
    try {
      if (await Utils.checkInternet()) {
        final value = await ApiService(_dio).getData(
          headerType: 2,
          url:
              '${ApiConstant.getCoursesDetail}/${params.id}?${ApiConstant.enroll}=${params.isEnroll}',
        );

        Utils.log('response -> $value');
        CourseDetailModel it = CourseDetailModel.fromJson(json.decode(value));
        if (it.code == '200') {
          return DataSuccess(it);
        } else {
          return DataFailed(
            DioException(
              requestOptions: RequestOptions(),
              message: it.message,
            ),
          );
        }
      } else {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(),
            message: Strings.internetConnectionMessage,
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DataState<MarkTopicCompleteModel>> markTopicComplete(
      MarkTopicCompleteParams markTopicCompleteParams) async {
    try {
      if (await Utils.checkInternet()) {
        final value = await ApiService(_dio).postData(
          headerType: 2,
          url: ApiConstant.markTopicComplete,
          body: {
            ApiConstant.courseId: markTopicCompleteParams.courseId,
            ApiConstant.topicId: markTopicCompleteParams.topicId,
            ApiConstant.userId: Prefs.getInt(key: Constants.userId),
          },
        );

        Utils.log('response -> $value');
        MarkTopicCompleteModel it =
            MarkTopicCompleteModel.fromJson(json.decode(value));
        if (it.code == '200') {
          return DataSuccess(it);
        } else {
          return DataFailed(
            DioException(
              requestOptions: RequestOptions(),
              message: it.message,
            ),
          );
        }
      } else {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(),
            message: Strings.internetConnectionMessage,
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
