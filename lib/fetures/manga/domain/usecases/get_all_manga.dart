import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/manga/domain/entities/manga_entity.dart';
import 'package:mangap/fetures/manga/domain/repositories/manga_repository.dart';

class GetAllManga implements UseCaseWithParams<List<MangaEntity>, int> {
  const GetAllManga({required MangaRepository repository})
      : _repository = repository;

  final MangaRepository _repository;

  @override
  ResultFuture<List<MangaEntity>> call(int page) =>
      _repository.getAllManga(page);
}
