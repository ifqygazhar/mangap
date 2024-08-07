import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/home/domain/entities/komik_popular_entity.dart';
import 'package:mangap/fetures/home/domain/repositories/home_repository.dart';

class GetPopularKomik
    implements UseCaseWithoutParams<List<KomikPopularEntity>> {
  GetPopularKomik({required HomeRepository repository})
      : _repository = repository;

  final HomeRepository _repository;

  @override
  ResultFuture<List<KomikPopularEntity>> call() => _repository.getPopular();
}
