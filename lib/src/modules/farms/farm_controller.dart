// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';
import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/models/gastos/diesel_model.dart';
import 'package:trab_apsoo/src/models/gastos/gastos_model.dart';
import 'package:trab_apsoo/src/models/gastos/sangria_model.dart';
import 'package:trab_apsoo/src/repositories/diesel/diesel_repository.dart';

import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
import 'package:trab_apsoo/src/repositories/gasto/gasto_repository.dart';
import 'package:trab_apsoo/src/repositories/sangria/sangria_repository.dart';

part 'farm_controller.g.dart';

enum FarmStateStatus {
  inital,
  loading,
  loaded,
  error,
  addOrUpdateFarm,
}

class FarmController = FarmControllerBase with _$FarmController;

abstract class FarmControllerBase with Store {
  final FarmRepository _farmRepository;
  final GastoRepository _gastoRepository;
  final SangriaRepository _sangriaRepository;
  final DieselRepository _dieselRepository;
  FarmControllerBase(
    this._farmRepository,
    this._gastoRepository,
    this._sangriaRepository,
    this._dieselRepository,
  );

  @readonly
  var _status = FarmStateStatus.inital;

  @readonly
  var _farms = <FarmModel>[];

  @readonly
  String? _filterName;

  @readonly
  List<GastosModel> _gastosByFarm = [];

  @readonly
  List<SangriaModel> _sangriaByFarm = [];

  @readonly
  List<DieselModel> _dieselByFarm = [];

  @readonly
  FarmModel? _farmSelected;

  // @action
  // Future<void> filterByName(String name) async {
  //   _filterName = name;
  //   await loadFarms();
  // }

  // @action
  // Future<void> loadFarms() async {
  //   try {
  //     _status = FarmStateStatus.loading;
  //     _farms = await _farmRepository.getFarms(_filterName);
  //     _status = FarmStateStatus.loaded;
  //   } catch (e, s) {
  //     log('Erro ao buscar fazendas', error: e, stackTrace: s);
  //     _status = FarmStateStatus.error;
  //   }
  // }

  @action
  Future<void> addFarm(FarmModel farm) async {
    try {
      _status = FarmStateStatus.loading;
      await Future.delayed(Duration.zero);
      _farmSelected = null;
      await _farmRepository.addOrEditFarms(farm);
      _status = FarmStateStatus.addOrUpdateFarm;
    } catch (e, s) {
      log('Erro ao adicionar fazendas', error: e, stackTrace: s);
      _status = FarmStateStatus.error;
    }
  }

  @action
  Future<void> loadGastosByFarmId(int? farmId) async {
    try {
      _status = FarmStateStatus.loading;
      _gastosByFarm = await _gastoRepository.getGastosByFarmId(farmId);
      _status = FarmStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar gastos da fazenda', error: e, stackTrace: s);
      _status = FarmStateStatus.error;
    }
  }

  @action
  Future<void> loadSangriasByFarmId(int? farmId) async {
    try {
      _status = FarmStateStatus.loading;
      _sangriaByFarm = await _sangriaRepository.getSangriaByFarmId(farmId);
      _status = FarmStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar sangrias da fazenda', error: e, stackTrace: s);
      _status = FarmStateStatus.error;
    }
  }

  @action
  Future<void> loadDieselByFarmId(int? farmId) async {
    try {
      _status = FarmStateStatus.loading;
      _dieselByFarm = await _dieselRepository.getDieselByFarmId(farmId);
      _status = FarmStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar diesel da fazenda', error: e, stackTrace: s);
      _status = FarmStateStatus.error;
    }
  }
}
