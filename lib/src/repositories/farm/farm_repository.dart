import 'package:trab_apsoo/src/models/farm/farm_model.dart';

abstract interface class FarmRepository {
  Future<List<FarmModel>> getFarms(String? nome);
  Future<void> addOrEditFarms(FarmModel farm);
  Future<void> farmDelete(id);
}
