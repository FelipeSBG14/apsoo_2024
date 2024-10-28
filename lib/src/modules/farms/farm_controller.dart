// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';

import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';

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
  FarmControllerBase(
    this._farmRepository,
  );

  @readonly
  var _status = FarmStateStatus.inital;

  @readonly
  var _farms = <FarmModel>[];

  @readonly
  String? _filterName;

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
  //     log('Erro ao buscar produtos', error: e, stackTrace: s);
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
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      _status = FarmStateStatus.error;
    }
  }
}
