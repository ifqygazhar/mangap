import 'package:mangap/core/usecases/usecase.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';
import 'package:mangap/fetures/read/domain/repositories/read_repository.dart';

class SaveChapter implements UseCaseWithParams<void, ReadEntity> {
  const SaveChapter({required ReadRepository repository})
      : _repository = repository;

  final ReadRepository _repository;

  @override
  ResultFuture<void> call(ReadEntity read) => _repository.saveChapter(read);
}
