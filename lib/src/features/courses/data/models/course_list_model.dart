import 'dart:convert';

import 'package:bestforming_cac/src/features/courses/data/models/course_detail_model.dart';
import 'package:bestforming_cac/src/features/courses/domain/entity/course_list_entity.dart';

CourseListModel courseListModelFromJson(String str) =>
    CourseListModel.fromJson(json.decode(str));

String courseListModelToJson(CourseListModel data) =>
    json.encode(data.toJson());

class CourseListModel extends CourseListEntity {
  const CourseListModel({
    super.code,
    super.message,
    super.data,
  });

  factory CourseListModel.fromJson(Map<String, dynamic> json) =>
      CourseListModel(
        code: json["code"],
        message: json["message"],
        data:
            json["data"] == null ? null : CourseListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class CourseListData {
  List<CourseData>? courses;
  int? total;
  int? page;
  int? perPage;
  int? totalPages;

  CourseListData({
    this.courses,
    this.total,
    this.page,
    this.perPage,
    this.totalPages,
  });

  factory CourseListData.fromJson(Map<String, dynamic> json) => CourseListData(
        courses: json["courses"] == null
            ? []
            : List<CourseData>.from(
                json["courses"]!.map((x) => CourseData.fromJson(x))),
        total: json["total"],
        page: json["page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "courses": courses == null
            ? []
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class CourseData {
  int? id;
  String? title;
  String? link;
  String? excerpt;
  String? content;
  String? featuredImage;
  List<String>? categories;
  bool? isEnrolled;
  String? courseStatus;
  double? progressPercent;
  int? totalSteps;
  int? completedSteps;
  dynamic certificate;
  List<TopicData>? nextStep;

  CourseData({
    this.id,
    this.title,
    this.link,
    this.excerpt,
    this.content,
    this.featuredImage,
    this.categories,
    this.isEnrolled,
    this.courseStatus,
    this.progressPercent,
    this.totalSteps,
    this.completedSteps,
    this.nextStep,
    this.certificate,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        excerpt: json["excerpt"],
        content: json["content"],
        featuredImage: json["featured_image"].toString() == 'false'
            ? ''
            : json["featured_image"],
        categories: json["categories"] == null
            ? []
            : List<String>.from(json["categories"]!.map((x) => x)),
        isEnrolled: json["is_enrolled"],
        courseStatus: json["course_status"],
        progressPercent: double.parse(json["progress_percent"].toString()),
        totalSteps: json["total_steps"],
        completedSteps: json["completed_steps"],
        certificate: json["certificate"],
        nextStep: json["next_step"] == null
            ? []
            : List<TopicData>.from(json["next_step"]!.map((x) => TopicData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "excerpt": excerpt,
        "content": content,
        "featured_image": featuredImage,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "is_enrolled": isEnrolled,
        "course_status": courseStatus,
        "progress_percent": progressPercent,
        "total_steps": totalSteps,
        "completed_steps": completedSteps,
        "certificate": certificate,
        "next_step": nextStep == null
            ? []
            : List<TopicData>.from(nextStep!.map((x) => x)),
      };
}
