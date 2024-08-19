import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';
import 'package:mangap/fetures/detail/domain/repositories/detail_repository.dart';

class DeletedDetailSavedKomik
    implements UseCaseWithParams<void, KomikDetailEntity> {
  const DeletedDetailSavedKomik({required DetailRepository repository})
      : _repository = repository;

  final DetailRepository _repository;

  @override
  ResultFuture<void> call(KomikDetailEntity detail) =>
      _repository.deleteSaveDetail(detail);
}
