import 'package:trab_apsoo/src/models/farm/farm_model.dart';

abstract class FarmRepository {
  Future<List<FarmModel>> getFarms(String? nome);
  Future<void> addOrEditFarms(FarmModel farm);
  Future<void> farmDelete(id);
}
