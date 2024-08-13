import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/search/domain/entities/search_entity.dart';

abstract class SearchRepository {
  const SearchRepository();

  ResultFuture<List<SearchEntity>> search(String keyword);
}
