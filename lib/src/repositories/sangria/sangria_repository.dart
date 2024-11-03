import 'package:trab_apsoo/src/models/gastos/sangria_model.dart';

abstract interface class SangriaRepository {
  Future<List<SangriaModel>> getSangrias(String? nome);
  Future<void> addOrEditSangrias(SangriaModel gasto);
  Future<void> sangriaDelete(id);
}
