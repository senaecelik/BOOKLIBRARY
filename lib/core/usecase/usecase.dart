abstract class UseCaseFuture<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UseCaseStream<Type, Params> {
  Stream<Type> call({required Params params});
}
