abstract class FutureUsecaseWithParams<Type, Params> {
  const FutureUsecaseWithParams();

  Future<Type> call(Params params);
}

abstract class FutureUsecaseWithoutParams<Type> {
  const FutureUsecaseWithoutParams();

  Future<Type> call();
}

abstract class StreamUsecaseWithoutParams<Type> {
  const StreamUsecaseWithoutParams();

  Future<Type> call();
}

abstract class StreamUsecaseWithParams<Type, Params> {
  const StreamUsecaseWithParams();

  Future<Type> call(Params params);
}
