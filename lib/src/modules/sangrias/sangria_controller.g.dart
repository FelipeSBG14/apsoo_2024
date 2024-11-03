// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sangria_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SangriaController on SangriaControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'SangriaControllerBase._status', context: context);

  SangriaStateStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  SangriaStateStatus get _status => status;

  @override
  set _status(SangriaStateStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_sangriasAtom =
      Atom(name: 'SangriaControllerBase._sangrias', context: context);

  List<SangriaModel> get sangrias {
    _$_sangriasAtom.reportRead();
    return super._sangrias;
  }

  @override
  List<SangriaModel> get _sangrias => sangrias;

  @override
  set _sangrias(List<SangriaModel> value) {
    _$_sangriasAtom.reportWrite(value, super._sangrias, () {
      super._sangrias = value;
    });
  }

  late final _$_farmsAtom =
      Atom(name: 'SangriaControllerBase._farms', context: context);

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
      Atom(name: 'SangriaControllerBase._filterName', context: context);

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
      Atom(name: 'SangriaControllerBase._farmSelected', context: context);

  SangriaModel? get farmSelected {
    _$_farmSelectedAtom.reportRead();
    return super._farmSelected;
  }

  @override
  SangriaModel? get _farmSelected => farmSelected;

  @override
  set _farmSelected(SangriaModel? value) {
    _$_farmSelectedAtom.reportWrite(value, super._farmSelected, () {
      super._farmSelected = value;
    });
  }

  late final _$addSangriaAsyncAction =
      AsyncAction('SangriaControllerBase.addSangria', context: context);

  @override
  Future<void> addSangria(SangriaModel sangria) {
    return _$addSangriaAsyncAction.run(() => super.addSangria(sangria));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
