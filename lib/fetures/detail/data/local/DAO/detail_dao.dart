import 'package:floor/floor.dart';
import 'package:mangap/fetures/detail/data/models/komik_detail_model.dart';

@dao
abstract class DetailDao {
  @insert
  Future<void> saveDetail(KomikDetailModel detail);

  @delete
  Future<void> deleteSavedDetail(KomikDetailModel detail);

  @Query('SELECT * FROM komik_detail')
  Future<List<KomikDetailModel>> getDetails();

  @Query('SELECT * FROM komik_detail WHERE href = :href')
  Future<KomikDetailModel?> getDetailByHref(String href);
}
