// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$_homeStatusAtom =
      Atom(name: 'HomeControllerBase._homeStatus', context: context);

  HomeStateStatus get homeStatus {
    _$_homeStatusAtom.reportRead();
    return super._homeStatus;
  }

  @override
  HomeStateStatus get _homeStatus => homeStatus;

  @override
  set _homeStatus(HomeStateStatus value) {
    _$_homeStatusAtom.reportWrite(value, super._homeStatus, () {
      super._homeStatus = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'HomeControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_farmListAtom =
      Atom(name: 'HomeControllerBase._farmList', context: context);

  List<FarmModel>? get farmList {
    _$_farmListAtom.reportRead();
    return super._farmList;
  }

  @override
  List<FarmModel>? get _farmList => farmList;

  @override
  set _farmList(List<FarmModel>? value) {
    _$_farmListAtom.reportWrite(value, super._farmList, () {
      super._farmList = value;
    });
  }

  late final _$_gastosListAtom =
      Atom(name: 'HomeControllerBase._gastosList', context: context);

  List<GastosModel>? get gastosList {
    _$_gastosListAtom.reportRead();
    return super._gastosList;
  }

  @override
  List<GastosModel>? get _gastosList => gastosList;

  @override
  set _gastosList(List<GastosModel>? value) {
    _$_gastosListAtom.reportWrite(value, super._gastosList, () {
      super._gastosList = value;
    });
  }

  late final _$_sangriasListAtom =
      Atom(name: 'HomeControllerBase._sangriasList', context: context);

  List<SangriaModel>? get sangriasList {
    _$_sangriasListAtom.reportRead();
    return super._sangriasList;
  }

  @override
  List<SangriaModel>? get _sangriasList => sangriasList;

  @override
  set _sangriasList(List<SangriaModel>? value) {
    _$_sangriasListAtom.reportWrite(value, super._sangriasList, () {
      super._sangriasList = value;
    });
  }

  late final _$_farmSearchAtom =
      Atom(name: 'HomeControllerBase._farmSearch', context: context);

  List<FarmModel>? get farmSearch {
    _$_farmSearchAtom.reportRead();
    return super._farmSearch;
  }

  @override
  List<FarmModel>? get _farmSearch => farmSearch;

  @override
  set _farmSearch(List<FarmModel>? value) {
    _$_farmSearchAtom.reportWrite(value, super._farmSearch, () {
      super._farmSearch = value;
    });
  }

  late final _$_gastosSearchAtom =
      Atom(name: 'HomeControllerBase._gastosSearch', context: context);

  List<GastosModel>? get gastosSearch {
    _$_gastosSearchAtom.reportRead();
    return super._gastosSearch;
  }

  @override
  List<GastosModel>? get _gastosSearch => gastosSearch;

  @override
  set _gastosSearch(List<GastosModel>? value) {
    _$_gastosSearchAtom.reportWrite(value, super._gastosSearch, () {
      super._gastosSearch = value;
    });
  }

  late final _$_sangriasSearchAtom =
      Atom(name: 'HomeControllerBase._sangriasSearch', context: context);

  List<SangriaModel>? get sangriasSearch {
    _$_sangriasSearchAtom.reportRead();
    return super._sangriasSearch;
  }

  @override
  List<SangriaModel>? get _sangriasSearch => sangriasSearch;

  @override
  set _sangriasSearch(List<SangriaModel>? value) {
    _$_sangriasSearchAtom.reportWrite(value, super._sangriasSearch, () {
      super._sangriasSearch = value;
    });
  }

  late final _$_filterNameAtom =
      Atom(name: 'HomeControllerBase._filterName', context: context);

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

  late final _$_errorMessageAtom =
      Atom(name: 'HomeControllerBase._errorMessage', context: context);

  String? get errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  String? get _errorMessage => errorMessage;

  @override
  set _errorMessage(String? value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$getAllFarmsAsyncAction =
      AsyncAction('HomeControllerBase.getAllFarms', context: context);

  @override
  Future<void> getAllFarms() {
    return _$getAllFarmsAsyncAction.run(() => super.getAllFarms());
  }

  late final _$getAllGastosAsyncAction =
      AsyncAction('HomeControllerBase.getAllGastos', context: context);

  @override
  Future<void> getAllGastos() {
    return _$getAllGastosAsyncAction.run(() => super.getAllGastos());
  }

  late final _$getAllSangriasAsyncAction =
      AsyncAction('HomeControllerBase.getAllSangrias', context: context);

  @override
  Future<void> getAllSangrias() {
    return _$getAllSangriasAsyncAction.run(() => super.getAllSangrias());
  }

  late final _$deleteGastoAsyncAction =
      AsyncAction('HomeControllerBase.deleteGasto', context: context);

  @override
  Future<void> deleteGasto(int id) {
    return _$deleteGastoAsyncAction.run(() => super.deleteGasto(id));
  }

  late final _$deleteSangriaAsyncAction =
      AsyncAction('HomeControllerBase.deleteSangria', context: context);

  @override
  Future<void> deleteSangria(int id) {
    return _$deleteSangriaAsyncAction.run(() => super.deleteSangria(id));
  }

  late final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase', context: context);

  @override
  void filterFarmByName(String name) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.filterFarmByName');
    try {
      return super.filterFarmByName(name);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterGastoByName(String name) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.filterGastoByName');
    try {
      return super.filterGastoByName(name);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterSangriaByName(String name) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.filterSangriaByName');
    try {
      return super.filterSangriaByName(name);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterGastosByFazenda(int farmId) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.filterGastosByFazenda');
    try {
      return super.filterGastosByFazenda(farmId);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterSangriaByFazenda(int farmId) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.filterSangriaByFazenda');
    try {
      return super.filterSangriaByFazenda(farmId);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
