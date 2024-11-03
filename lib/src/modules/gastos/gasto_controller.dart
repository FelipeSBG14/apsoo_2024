import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/models/gastos/gastos_model.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
import 'package:trab_apsoo/src/repositories/gasto/gasto_repository.dart';
part 'gasto_controller.g.dart';

class GastoController = GastoControllerBase with _$GastoController;

enum GastoStateStatus {
  inital,
  loading,
  loaded,
  error,
  addOrUpdateGasto,
}

abstract class GastoControllerBase with Store {
  final GastoRepository _gastoRepository;
  final FarmRepository _farmRepository;
  GastoControllerBase(
    this._gastoRepository,
    this._farmRepository,
  );

  @readonly
  var _status = GastoStateStatus.inital;

  @readonly
  var _gastos = <GastosModel>[];

  @readonly
  var _farms = <FarmModel>[];

  @readonly
  String? _filterName;

  @readonly
  GastosModel? _farmSelected;

  @action
  Future<void> addGasto(GastosModel gasto) async {
    try {
      _status = GastoStateStatus.loading;
      await Future.delayed(Duration.zero);
      await _gastoRepository.addOrEditGastos(gasto);
      _status = GastoStateStatus.addOrUpdateGasto;
    } catch (e, s) {
      log('Erro ao adicionar gasto', error: e, stackTrace: s);
      _status = GastoStateStatus.error;
    }
  }

  Future<void> loadFarms() async {
    _farms.clear();
    try {
      _status = GastoStateStatus.loading;
      final result = await _farmRepository.getFarms(null);
      _farms.addAll(result);
      _status = GastoStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar fazendas', error: e, stackTrace: s);
      _status = GastoStateStatus.error;
    }
  }
}
