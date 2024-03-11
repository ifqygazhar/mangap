import 'package:mangap/core/errors/failures.dart';
import 'package:mangap/core/constants/app_constant.dart';

String errorMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure _:
      return AppConstant.serverFailureMessage;
    case CacheFailure _:
      return AppConstant.cacheFailureMessage;
    default:
      return AppConstant.generalFailureMessage;
  }
}
