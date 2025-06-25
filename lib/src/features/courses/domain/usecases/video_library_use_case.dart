import 'package:bestforming_cac/core/usecases/usecases.dart';
import 'package:bestforming_cac/src/features/courses/domain/entity/video_library_entity.dart';
import 'package:bestforming_cac/src/features/courses/domain/repo/courses_repo.dart';
import 'package:bestforming_cac/src/shared/data_state.dart';

class VideoLibraryUseCase
    extends FutureUsecaseWithoutParams<DataState<VideoLibraryEntity>> {
  const VideoLibraryUseCase(this._repo);

  final CoursesRepo _repo;

  @override
  Future<DataState<VideoLibraryEntity>> call() => _repo.getVideoLibrary();
}
