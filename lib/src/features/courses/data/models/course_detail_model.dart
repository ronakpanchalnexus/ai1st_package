import 'dart:convert';

import 'package:bestforming_cac/src/features/courses/domain/entity/course_detail_entity.dart';
import 'package:flutter/material.dart';

CourseDetailModel courseDetailModelFromJson(String str) =>
    CourseDetailModel.fromJson(json.decode(str));

String courseDetailModelToJson(CourseDetailModel data) =>
    json.encode(data.toJson());

class CourseDetailModel extends CourseDetailEntity {
  const CourseDetailModel({
    super.code,
    super.message,
    super.data,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      CourseDetailModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : CourseDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class CourseDetailData {
  int? id;
  String? title;
  String? content;
  String? featuredImage;
  List<String>? categories;
  bool? isEnrolled;
  String? courseStatus;
  String? progressPercent;
  String? certificateUrl;
  String? certificate;
  List<LessonData>? lessons;

  CourseDetailData({
    this.id,
    this.title,
    this.content,
    this.featuredImage,
    this.categories,
    this.isEnrolled,
    this.courseStatus,
    this.progressPercent,
    this.certificateUrl,
    this.certificate,
    this.lessons,
  });

  factory CourseDetailData.fromJson(Map<String, dynamic> json) =>
      CourseDetailData(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        featuredImage: json["featured_image"].toString() == 'false'
            ? ''
            : json["featured_image"],
        categories: json["categories"] == null
            ? []
            : List<String>.from(json["categories"]!.map((x) => x)),
        isEnrolled: json["is_enrolled"],
        courseStatus: json["course_status"],
        progressPercent: json["progress_percent"].toString(),
        certificateUrl: json["certificate_url"],
        certificate: json["certificate"],
        lessons: json["lessons"] == null
            ? []
            : List<LessonData>.from(
                json["lessons"]!.map((x) => LessonData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "featured_image": featuredImage,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "is_enrolled": isEnrolled,
        "course_status": courseStatus,
        "progress_percent": progressPercent,
        "certificate_url": certificateUrl,
        "certificate": certificate,
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons!.map((x) => x.toJson())),
      };
}

class LessonData {
  int? id;
  String? title;
  String? content;
  List<TopicData>? topics;
  ExpansionTileController? expansionTileController;

  LessonData({
    this.id,
    this.title,
    this.content,
    this.topics,
    this.expansionTileController,
  });

  factory LessonData.fromJson(Map<String, dynamic> json) => LessonData(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        topics: json["topics"] == null
            ? []
            : List<TopicData>.from(
                json["topics"]!.map((x) => TopicData.fromJson(x))),
        expansionTileController: ExpansionTileController(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "topics": topics == null
            ? []
            : List<dynamic>.from(topics!.map((x) => x.toJson())),
      };
}

class TopicData {
  int? id;
  String? title;
  String? content;
  String? bunnyVideo;
  String? subtitleFile;
  bool? isUnlock;
  bool? taskComplete;

  TopicData({
    this.id,
    this.title,
    this.content,
    this.bunnyVideo,
    this.subtitleFile,
    this.isUnlock,
    this.taskComplete,
  });

  factory TopicData.fromJson(Map<String, dynamic> json) => TopicData(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        bunnyVideo: json["bunny_video"],
        subtitleFile: json["subtitle_file"],
        isUnlock: json["is_unlock"],
        taskComplete: json["task_complete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "bunny_video": bunnyVideo,
        "subtitle_file": subtitleFile,
        "is_unlock": isUnlock,
        "task_complete": taskComplete,
      };
}
