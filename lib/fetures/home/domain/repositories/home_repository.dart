import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/home/domain/entities/komik_genre.dart';
import 'package:mangap/fetures/home/domain/entities/komik_popular_entity.dart';
import 'package:mangap/fetures/home/domain/entities/komik_recommended_entity.dart';

abstract class HomeRepository {
  const HomeRepository();

  ResultFuture<List<KomikPopularEntity>> getPopular();
  ResultFuture<List<KomikRecommendedEntity>> getRecommended();
  ResultFuture<List<KomikGenreEntity>> getGenre();
}
