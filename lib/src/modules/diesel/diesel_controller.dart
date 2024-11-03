import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/models/gastos/diesel_model.dart';
import 'package:trab_apsoo/src/repositories/diesel/diesel_repository.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
part 'diesel_controller.g.dart';

class DieselController = DieselControllerBase with _$DieselController;

enum DieselStateStatus {
  inital,
  loading,
  loaded,
  error,
  addOrUpdateDiesel,
}

abstract class DieselControllerBase with Store {
  final DieselRepository _dieselRepository;
  final FarmRepository _farmRepository;
  DieselControllerBase(
    this._dieselRepository,
    this._farmRepository,
  );

  @readonly
  var _status = DieselStateStatus.inital;

  @readonly
  var _diesels = <DieselModel>[];

  @readonly
  var _farms = <FarmModel>[];

  @readonly
  String? _filterName;

  @readonly
  DieselModel? _farmSelected;

  @action
  Future<void> addDiesel(DieselModel diesel) async {
    try {
      _status = DieselStateStatus.loading;
      await Future.delayed(Duration.zero);
      await _dieselRepository.addOrEditDiesel(diesel);
      _status = DieselStateStatus.addOrUpdateDiesel;
    } catch (e, s) {
      log('Erro ao adicionar diesel', error: e, stackTrace: s);
      _status = DieselStateStatus.error;
    }
  }

  Future<void> loadFarms() async {
    _farms.clear();
    try {
      _status = DieselStateStatus.loading;
      final result = await _farmRepository.getFarms(null);
      _farms.addAll(result);
      _status = DieselStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar fazendas', error: e, stackTrace: s);
      _status = DieselStateStatus.error;
    }
  }
}
