import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/models/gastos/gastos_model.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
import 'package:trab_apsoo/src/repositories/gasto/gasto_repository.dart';
part 'home_controller.g.dart';

enum HomeStateStatus {
  inital,
  loading,
  success,
  uploaded,
  loaded,
  addOrEdit,
  error;
}

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final FarmRepository _farmRepository;
  final GastoRepository _gastosRepository;

  HomeControllerBase(
    this._farmRepository,
    this._gastosRepository,
  );
  @readonly
  HomeStateStatus _homeStatus = HomeStateStatus.inital;

  @observable
  bool isLoading = false;

  @readonly
  List<FarmModel>? _farmList;

  @readonly
  List<GastosModel>? _gastosList;

  @readonly
  List<FarmModel>? _farmSearch;

  @readonly
  List<GastosModel>? _gastosSearch;

  @readonly
  String? _filterName;

  @readonly
  String? _errorMessage;

  @action
  Future<void> getAllFarms() async {
    try {
      _homeStatus = HomeStateStatus.loading;
      _farmList = await _farmRepository.getFarms(_filterName);
      _farmSearch = _farmList;
      _homeStatus = HomeStateStatus.success;
    } catch (e, s) {
      log('Erro ao buscar fazendas', error: e, stackTrace: s);
      _homeStatus = HomeStateStatus.error;
      _farmList = [];
    }
  }

  @action
  Future<void> getAllGastos() async {
    try {
      _homeStatus = HomeStateStatus.loading;
      _gastosList = await _gastosRepository.getGastos(_filterName);
      _gastosSearch = _gastosList;
      _homeStatus = HomeStateStatus.success;
    } catch (e, s) {
      log('Erro ao buscar gastos', error: e, stackTrace: s);
      _homeStatus = HomeStateStatus.error;
      _gastosList = [];
    }
  }

  @action
  Future<void> deleteGasto(int id) async {
    try {
      _homeStatus = HomeStateStatus.loading;
      await _gastosRepository.gastoDelete(id);
      await getAllFarms();
      _homeStatus = HomeStateStatus.success;
    } catch (e, s) {
      log('Erro ao buscar gastos', error: e, stackTrace: s);
      _homeStatus = HomeStateStatus.error;
    }
  }

  @action
  void filterFarmByName(String name) {
    _farmSearch = _farmList
        ?.where(
          (p) =>
              (p.nome).trim().toUpperCase().contains(name.trim().toUpperCase()),
        )
        .toList();
  }

  @action
  void filterGastoByName(String name) {
    _gastosSearch = _gastosList
        ?.where(
          (p) => (p.descricao)
              .trim()
              .toUpperCase()
              .contains(name.trim().toUpperCase()),
        )
        .toList();
  }

  @action
  void filterByFazenda(int farmId) {
    _gastosSearch =
        _gastosList?.where((gasto) => gasto.farmId == farmId).toList() ?? [];

    // Se a lista estiver vazia, talvez queira também emitir uma mensagem
    if (_gastosSearch!.isEmpty) {
      _errorMessage = "Nenhum gasto encontrado para esta fazenda.";
    } else {
      _errorMessage = null; // Reseta a mensagem de erro se houver resultados
    }
  }
}
