// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gasto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GastoController on GastoControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'GastoControllerBase._status', context: context);

  GastoStateStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  GastoStateStatus get _status => status;

  @override
  set _status(GastoStateStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_gastosAtom =
      Atom(name: 'GastoControllerBase._gastos', context: context);

  List<GastosModel> get gastos {
    _$_gastosAtom.reportRead();
    return super._gastos;
  }

  @override
  List<GastosModel> get _gastos => gastos;

  @override
  set _gastos(List<GastosModel> value) {
    _$_gastosAtom.reportWrite(value, super._gastos, () {
      super._gastos = value;
    });
  }

  late final _$_farmsAtom =
      Atom(name: 'GastoControllerBase._farms', context: context);

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
      Atom(name: 'GastoControllerBase._filterName', context: context);

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
      Atom(name: 'GastoControllerBase._farmSelected', context: context);

  GastosModel? get farmSelected {
    _$_farmSelectedAtom.reportRead();
    return super._farmSelected;
  }

  @override
  GastosModel? get _farmSelected => farmSelected;

  @override
  set _farmSelected(GastosModel? value) {
    _$_farmSelectedAtom.reportWrite(value, super._farmSelected, () {
      super._farmSelected = value;
    });
  }

  late final _$addGastoAsyncAction =
      AsyncAction('GastoControllerBase.addGasto', context: context);

  @override
  Future<void> addGasto(GastosModel gasto) {
    return _$addGastoAsyncAction.run(() => super.addGasto(gasto));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
