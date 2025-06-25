import 'dart:convert';

import 'package:bestforming_cac/src/features/courses/domain/entity/mark_topic_complete_entity.dart';

String markTopicCompleteModelToJson(MarkTopicCompleteModel data) =>
    json.encode(data.toJson());

class MarkTopicCompleteModel extends MarkTopicCompleteEntity {
  const MarkTopicCompleteModel({
    super.code,
    super.message,
  });

  factory MarkTopicCompleteModel.fromJson(Map<String, dynamic> json) =>
      MarkTopicCompleteModel(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
