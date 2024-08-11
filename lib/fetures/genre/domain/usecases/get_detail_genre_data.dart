import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/genre/domain/entities/genre_detail_entity.dart';
import 'package:mangap/fetures/genre/domain/repositories/genre_repository.dart';

class GetDetailGenreData
    implements
        UseCaseWithThreeParams<List<KomikGenreDetailDataEntity>, String, int> {
  const GetDetailGenreData({required GenreRepository repository})
      : _repository = repository;

  final GenreRepository _repository;

  @override
  ResultFuture<List<KomikGenreDetailDataEntity>> call(String href, int page) =>
      _repository.getGenre(href, page);
}
