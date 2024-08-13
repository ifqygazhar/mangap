import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/search/domain/entities/search_entity.dart';
import 'package:mangap/fetures/search/domain/repositories/search_repository.dart';

class GetSearch implements UseCaseWithParams<List<SearchEntity>, String> {
  const GetSearch({required SearchRepository repository})
      : _repository = repository;

  final SearchRepository _repository;

  @override
  ResultFuture<List<SearchEntity>> call(String keyword) =>
      _repository.search(keyword);
}
