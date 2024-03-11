import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/home/domain/entities/komik_entity.dart';

abstract class HomeRepository {
  const HomeRepository();

  ResultFuture<List<KomikEntity>> getPopular();
  ResultFuture<List<KomikEntity>> getLatest();
}
