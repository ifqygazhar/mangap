import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/home/domain/entities/komik_entity.dart';
import 'package:mangap/fetures/home/domain/repositories/home_repository.dart';

class GetLatestKomik implements UseCaseWithoutParams<List<KomikEntity>> {
  GetLatestKomik({required HomeRepository repository})
      : _repository = repository;

  final HomeRepository _repository;

  @override
  ResultFuture<List<KomikEntity>> call() => _repository.getLatest();
}
