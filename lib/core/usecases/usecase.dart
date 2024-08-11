import 'package:mangap/core/utils/typedef.dart';

abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();

  ResultFuture<Type> call();
}

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithThreeParams<Type, Params, Params2> {
  const UseCaseWithThreeParams();

  ResultFuture<Type> call(Params params, Params2 params2);
}
