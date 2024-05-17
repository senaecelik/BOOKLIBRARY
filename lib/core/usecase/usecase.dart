abstract class UseCase<Type, Params> {
  Future<Type> call({required Params params});
}

abstract class UseCaseStream<Type, Params> {
  Stream<Type> call({required Params params});
}
