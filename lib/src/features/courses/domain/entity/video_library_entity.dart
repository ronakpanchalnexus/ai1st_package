import 'package:ai1st_package/src/features/courses/data/models/video_library_model.dart';
import 'package:equatable/equatable.dart';

class VideoLibraryEntity extends Equatable {
  final String? code;
  final String? message;
  final VideoLibraryData? data;

  const VideoLibraryEntity({
    this.code,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [code, message, data];
}
