import 'package:trab_apsoo/src/models/gastos/diesel_model.dart';

abstract interface class DieselRepository {
  Future<List<DieselModel>> getDiesels(String? nome);
  Future<void> addOrEditDiesel(DieselModel gasto);
  Future<void> dieselDelete(id);
  Future<List<DieselModel>> getDieselByFarmId(int? farmId);
  Future<void> deleteAllDieselByFarmId(int farmId);
}
