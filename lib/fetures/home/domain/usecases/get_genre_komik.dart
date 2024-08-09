import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/home/domain/entities/komik_genre.dart';
import 'package:mangap/fetures/home/domain/repositories/home_repository.dart';

class GetGenreKomik implements UseCaseWithoutParams<List<KomikGenreEntity>> {
  GetGenreKomik({required HomeRepository repository})
      : _repository = repository;

  final HomeRepository _repository;
  @override
  ResultFuture<List<KomikGenreEntity>> call() => _repository.getGenre();
}
