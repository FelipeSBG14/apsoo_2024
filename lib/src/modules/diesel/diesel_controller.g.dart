// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diesel_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DieselController on DieselControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'DieselControllerBase._status', context: context);

  DieselStateStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  DieselStateStatus get _status => status;

  @override
  set _status(DieselStateStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_dieselsAtom =
      Atom(name: 'DieselControllerBase._diesels', context: context);

  List<DieselModel> get diesels {
    _$_dieselsAtom.reportRead();
    return super._diesels;
  }

  @override
  List<DieselModel> get _diesels => diesels;

  @override
  set _diesels(List<DieselModel> value) {
    _$_dieselsAtom.reportWrite(value, super._diesels, () {
      super._diesels = value;
    });
  }

  late final _$_farmsAtom =
      Atom(name: 'DieselControllerBase._farms', context: context);

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
      Atom(name: 'DieselControllerBase._filterName', context: context);

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

  late final _$_farmSelectedAtom =
      Atom(name: 'DieselControllerBase._farmSelected', context: context);

  DieselModel? get farmSelected {
    _$_farmSelectedAtom.reportRead();
    return super._farmSelected;
  }

  @override
  DieselModel? get _farmSelected => farmSelected;

  @override
  set _farmSelected(DieselModel? value) {
    _$_farmSelectedAtom.reportWrite(value, super._farmSelected, () {
      super._farmSelected = value;
    });
  }

  late final _$addDieselAsyncAction =
      AsyncAction('DieselControllerBase.addDiesel', context: context);

  @override
  Future<void> addDiesel(DieselModel diesel) {
    return _$addDieselAsyncAction.run(() => super.addDiesel(diesel));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
