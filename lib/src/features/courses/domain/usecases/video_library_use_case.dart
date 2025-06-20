import 'package:ai1st_package/core/usecases/usecases.dart';
import 'package:ai1st_package/src/features/courses/domain/entity/video_library_entity.dart';
import 'package:ai1st_package/src/features/courses/domain/repo/courses_repo.dart';
import 'package:ai1st_package/src/shared/data_state.dart';

class VideoLibraryUseCase
    extends FutureUsecaseWithoutParams<DataState<VideoLibraryEntity>> {
  const VideoLibraryUseCase(this._repo);

  final CoursesRepo _repo;

  @override
  Future<DataState<VideoLibraryEntity>> call() => _repo.getVideoLibrary();
}
