import 'dart:convert';

import 'package:ai1st_package/src/features/courses/domain/entity/video_library_entity.dart';

VideoLibraryModel videoLibraryModelFromJson(String str) =>
    VideoLibraryModel.fromJson(json.decode(str));

String videoLibraryModelToJson(VideoLibraryModel data) =>
    json.encode(data.toJson());

class VideoLibraryModel extends VideoLibraryEntity {
  const VideoLibraryModel({
    super.code,
    super.message,
    super.data,
  });

  factory VideoLibraryModel.fromJson(Map<String, dynamic> json) =>
      VideoLibraryModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : VideoLibraryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class VideoLibraryData {
  List<VideoData>? videos;
  int? total;
  int? page;
  int? perPage;
  int? totalPages;

  VideoLibraryData({
    this.videos,
    this.total,
    this.page,
    this.perPage,
    this.totalPages,
  });

  factory VideoLibraryData.fromJson(Map<String, dynamic> json) =>
      VideoLibraryData(
        videos: json["videos"] == null
            ? []
            : List<VideoData>.from(
                json["videos"]!.map((x) => VideoData.fromJson(x))),
        total: json["total"],
        page: json["page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "videos": videos == null
            ? []
            : List<dynamic>.from(videos!.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class VideoData {
  int? id;
  String? title;
  String? link;
  String? excerpt;
  String? content;
  String? bunnyVideo;
  String? subtitleFile;
  String? featuredImage;
  List<String>? categories;
  List<String>? tags;
  int? views;
  String? duration;
  String? date;

  VideoData({
    this.id,
    this.title,
    this.link,
    this.excerpt,
    this.content,
    this.bunnyVideo,
    this.subtitleFile,
    this.featuredImage,
    this.categories,
    this.tags,
    this.views,
    this.duration,
    this.date,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        excerpt: json["excerpt"],
        content: json["content"],
        bunnyVideo: json["bunny_video"],
        subtitleFile: json["subtitle_file"],
        featuredImage: json["featured_image"],
        categories: json["categories"] == null
            ? []
            : List<String>.from(json["categories"]!.map((x) => x)),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        views: json["views"],
        duration: json["duration"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "excerpt": excerpt,
        "content": content,
        "bunny_video": bunnyVideo,
        "subtitle_file": subtitleFile,
        "featured_image": featuredImage,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "views": views,
        "duration": duration,
        "date": date,
      };
}
