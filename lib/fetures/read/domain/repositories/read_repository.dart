import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';

abstract class ReadRepository {
  const ReadRepository();
  ResultFuture<List<ReadEntity>> read(String href);
}
