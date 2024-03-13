import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';
import 'package:mangap/fetures/detail/domain/repositories/detail_repository.dart';

class GetDetail implements UseCaseWithParams<List<KomikDetailEntity>, String> {
  const GetDetail({required DetailRepository repository})
      : _repository = repository;

  final DetailRepository _repository;

  @override
  ResultFuture<List<KomikDetailEntity>> call(String slug) =>
      _repository.getDetail(slug);
}
