import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/models/gastos/sangria_model.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
import 'package:trab_apsoo/src/repositories/sangria/sangria_repository.dart';
part 'sangria_controller.g.dart';

class SangriaController = SangriaControllerBase with _$SangriaController;

enum SangriaStateStatus {
  inital,
  loading,
  loaded,
  error,
  addOrUpdateSangria,
}

abstract class SangriaControllerBase with Store {
  final SangriaRepository _sangriaRepository;
  final FarmRepository _farmRepository;
  SangriaControllerBase(
    this._sangriaRepository,
    this._farmRepository,
  );

  @readonly
  var _status = SangriaStateStatus.inital;

  @readonly
  var _sangrias = <SangriaModel>[];

  @readonly
  var _farms = <FarmModel>[];

  @readonly
  String? _filterName;

  @readonly
  SangriaModel? _farmSelected;

  @action
  Future<void> addSangria(SangriaModel sangria) async {
    try {
      _status = SangriaStateStatus.loading;
      await Future.delayed(Duration.zero);
      await _sangriaRepository.addOrEditSangrias(sangria);
      _status = SangriaStateStatus.addOrUpdateSangria;
    } catch (e, s) {
      log('Erro ao adicionar sangria', error: e, stackTrace: s);
      _status = SangriaStateStatus.error;
    }
  }

  Future<void> loadFarms() async {
    _farms.clear();
    try {
      _status = SangriaStateStatus.loading;
      final result = await _farmRepository.getFarms(null);
      _farms.addAll(result);
      _status = SangriaStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar fazendas', error: e, stackTrace: s);
      _status = SangriaStateStatus.error;
    }
  }
}
