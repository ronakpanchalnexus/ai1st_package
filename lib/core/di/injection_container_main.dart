part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
  await _initCourses();
  await Prefs.init();
}

_initOnBoarding() async {
  sl.registerLazySingleton(() => NavigationService());
}

_initAuth() async {
  sl
    ..registerFactory(() => AuthenticationBloc(
          signInUseCase: sl(),
          forgotPasswordUseCase: sl(),
        ))
    ..registerLazySingleton(() => SignedInStateSuccess(sl()))
    ..registerLazySingleton(() => SignedInStateFailed(sl()))
    ..registerLazySingleton(() => ForgotPasswordStateSuccess(sl()))
    ..registerLazySingleton(() => ForgotPasswordStateFailed(sl()))
    ..registerLazySingleton(() => TogglePasswordState(sl()))
    ..registerLazySingleton(() => SignInUseCase(sl()))
    ..registerLazySingleton(() => ForgotPasswordUseCase(sl()))
    ..registerLazySingleton<AuthenticationRepo>(
      () => AuthenticationRepoImplementation(sl()),
    )
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImplementation(dio: sl()),
    );
}

_initCourses() async {
  sl
    ..registerFactory(
      () => CoursesBloc(
        videoLibraryUseCase: sl(),
        courseListUseCase: sl(),
        courseDetailUseCase: sl(),
        markTopicCompleteUseCase: sl(),
      ),
    )
    ..registerLazySingleton(() => VideoLibraryStateSuccess(sl()))
    ..registerLazySingleton(() => VideoLibraryStateFailed(sl()))
    ..registerLazySingleton(() => CourseListStateSuccess(sl()))
    ..registerLazySingleton(() => CourseListStateFailed(sl()))
    ..registerLazySingleton(() => CourseDetailStateSuccess(sl()))
    ..registerLazySingleton(() => CourseDetailStateFailed(sl()))
    ..registerLazySingleton(() => MarkTopicCompleteStateSuccess(sl(), sl()))
    ..registerLazySingleton(() => MarkTopicCompleteStateFailed(sl()))
    ..registerLazySingleton(() => VideoLibraryUseCase(sl()))
    ..registerLazySingleton(() => CourseListUseCase(sl()))
    ..registerLazySingleton(() => CourseDetailUseCase(sl()))
    ..registerLazySingleton(() => MarkTopicCompleteUseCase(sl()))
    ..registerLazySingleton<CoursesRepo>(
      () => CoursesRepoImplementation(sl()),
    )
    ..registerLazySingleton<CoursesRemoteDataSource>(
      () => CoursesRemoteDataSourceImplementation(dio: sl()),
    );
}
