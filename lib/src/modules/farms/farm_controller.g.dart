// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FarmController on FarmControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'FarmControllerBase._status', context: context);

  FarmStateStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  FarmStateStatus get _status => status;

  @override
  set _status(FarmStateStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_farmsAtom =
      Atom(name: 'FarmControllerBase._farms', context: context);

  List<FarmModel> get farms {
    _$_farmsAtom.reportRead();
    return super._farms;
  }

  @override
  List<FarmModel> get _farms => farms;

  @override
  set _farms(List<FarmModel> value) {
    _$_farmsAtom.reportWrite(value, super._farms, () {
      super._farms = value;
    });
  }

  late final _$_filterNameAtom =
      Atom(name: 'FarmControllerBase._filterName', context: context);

  String? get filterName {
    _$_filterNameAtom.reportRead();
    return super._filterName;
  }

  @override
  String? get _filterName => filterName;

  @override
  set _filterName(String? value) {
    _$_filterNameAtom.reportWrite(value, super._filterName, () {
      super._filterName = value;
    });
  }

  late final _$_gastosByFarmAtom =
      Atom(name: 'FarmControllerBase._gastosByFarm', context: context);

  List<GastosModel> get gastosByFarm {
    _$_gastosByFarmAtom.reportRead();
    return super._gastosByFarm;
  }

  @override
  List<GastosModel> get _gastosByFarm => gastosByFarm;

  @override
  set _gastosByFarm(List<GastosModel> value) {
    _$_gastosByFarmAtom.reportWrite(value, super._gastosByFarm, () {
      super._gastosByFarm = value;
    });
  }

  late final _$_sangriaByFarmAtom =
      Atom(name: 'FarmControllerBase._sangriaByFarm', context: context);

  List<SangriaModel> get sangriaByFarm {
    _$_sangriaByFarmAtom.reportRead();
    return super._sangriaByFarm;
  }

  @override
  List<SangriaModel> get _sangriaByFarm => sangriaByFarm;

  @override
  set _sangriaByFarm(List<SangriaModel> value) {
    _$_sangriaByFarmAtom.reportWrite(value, super._sangriaByFarm, () {
      super._sangriaByFarm = value;
    });
  }

  late final _$_dieselByFarmAtom =
      Atom(name: 'FarmControllerBase._dieselByFarm', context: context);

  List<DieselModel> get dieselByFarm {
    _$_dieselByFarmAtom.reportRead();
    return super._dieselByFarm;
  }

  @override
  List<DieselModel> get _dieselByFarm => dieselByFarm;

  @override
  set _dieselByFarm(List<DieselModel> value) {
    _$_dieselByFarmAtom.reportWrite(value, super._dieselByFarm, () {
      super._dieselByFarm = value;
    });
  }

  late final _$_farmSelectedAtom =
      Atom(name: 'FarmControllerBase._farmSelected', context: context);

  FarmModel? get farmSelected {
    _$_farmSelectedAtom.reportRead();
    return super._farmSelected;
  }

  @override
  FarmModel? get _farmSelected => farmSelected;

  @override
  set _farmSelected(FarmModel? value) {
    _$_farmSelectedAtom.reportWrite(value, super._farmSelected, () {
      super._farmSelected = value;
    });
  }

  late final _$addFarmAsyncAction =
      AsyncAction('FarmControllerBase.addFarm', context: context);

  @override
  Future<void> addFarm(FarmModel farm) {
    return _$addFarmAsyncAction.run(() => super.addFarm(farm));
  }

  late final _$loadGastosByFarmIdAsyncAction =
      AsyncAction('FarmControllerBase.loadGastosByFarmId', context: context);

  @override
  Future<void> loadGastosByFarmId(int? farmId) {
    return _$loadGastosByFarmIdAsyncAction
        .run(() => super.loadGastosByFarmId(farmId));
  }

  late final _$loadSangriasByFarmIdAsyncAction =
      AsyncAction('FarmControllerBase.loadSangriasByFarmId', context: context);

  @override
  Future<void> loadSangriasByFarmId(int? farmId) {
    return _$loadSangriasByFarmIdAsyncAction
        .run(() => super.loadSangriasByFarmId(farmId));
  }

  late final _$loadDieselByFarmIdAsyncAction =
      AsyncAction('FarmControllerBase.loadDieselByFarmId', context: context);

  @override
  Future<void> loadDieselByFarmId(int? farmId) {
    return _$loadDieselByFarmIdAsyncAction
        .run(() => super.loadDieselByFarmId(farmId));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
