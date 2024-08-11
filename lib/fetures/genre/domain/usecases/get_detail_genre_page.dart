import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/genre/domain/entities/genre_detail_entity.dart';
import 'package:mangap/fetures/genre/domain/repositories/genre_repository.dart';

class GetGenrePage
    implements UseCaseWithThreeParams<KomikGenreDetailEntity, String, int> {
  const GetGenrePage({required GenreRepository repository})
      : _repository = repository;

  final GenreRepository _repository;

  @override
  ResultFuture<KomikGenreDetailEntity> call(String href, int page) =>
      _repository.getGenrePage(href, page);
}
