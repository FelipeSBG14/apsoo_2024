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

  late final _$_farmsAtom =
      Atom(name: 'HomeControllerBase._farms', context: context);

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
  Future<void> getAllFarms(FarmModel farm) {
    return _$getAllFarmsAsyncAction.run(() => super.getAllFarms(farm));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
