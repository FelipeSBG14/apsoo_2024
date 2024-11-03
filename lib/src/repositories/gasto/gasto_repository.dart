import 'package:trab_apsoo/src/models/gastos/gastos_model.dart';

abstract interface class GastoRepository {
  Future<List<GastosModel>> getGastos(String? nome);
  Future<void> addOrEditGastos(GastosModel gasto);
  Future<void> gastoDelete(id);
}