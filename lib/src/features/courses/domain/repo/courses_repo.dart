import 'package:ai1st_package/src/features/courses/domain/entity/course_detail_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/entity/course_list_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/entity/mark_topic_complete_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/entity/video_library_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/usecases/mark_topic_complete_use_case.dart';
import 'package:ai1st_package/src/shared/data_state.dart';

import '../usecases/course_detail_use_case.dart';

abstract class CoursesRepo {
  const CoursesRepo();

  Future<DataState<VideoLibraryEntity>> getVideoLibrary();

  Future<DataState<CourseListEntity>> getCourseList();

  Future<DataState<CourseDetailEntity>> getCourseDetail(
      CourseDetailParams params);

  Future<DataState<MarkTopicCompleteEntity>> markTopicComplete(
      MarkTopicCompleteParams markTopicCompleteParams);
}
