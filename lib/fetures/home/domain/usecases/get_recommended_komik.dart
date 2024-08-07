import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/home/domain/entities/komik_recommended_entity.dart';
import 'package:mangap/fetures/home/domain/repositories/home_repository.dart';

class GetRecommended
    implements UseCaseWithoutParams<List<KomikRecommendedEntity>> {
  const GetRecommended({required HomeRepository repository})
      : _repository = repository;

  final HomeRepository _repository;

  @override
  ResultFuture<List<KomikRecommendedEntity>> call() =>
      _repository.getRecommended();
}
