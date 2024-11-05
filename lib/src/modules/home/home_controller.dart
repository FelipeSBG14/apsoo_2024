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
part 'home_controller.g.dart';

enum HomeStateStatus {
  inital,
  loading,
  success,
  uploaded,
  loaded,
  addOrEdit,
  farmDeleted,
  error;
}

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final FarmRepository _farmRepository;
  final GastoRepository _gastosRepository;
  final SangriaRepository _sangriaRepository;
  final DieselRepository _dieselRepository;

  HomeControllerBase(
    this._farmRepository,
    this._gastosRepository,
    this._sangriaRepository,
    this._dieselRepository,
  );
  @readonly
  HomeStateStatus _homeStatus = HomeStateStatus.inital;

  @observable
  bool isLoading = false;

  @readonly
  List<FarmModel>? _farmList = [];

  @readonly
  List<GastosModel>? _gastosList = [];

  @readonly
  List<SangriaModel>? _sangriasList = [];

  @readonly
  List<DieselModel>? _dieselList = [];

  @readonly
  List<FarmModel>? _farmSearch = [];

  @readonly
  List<GastosModel>? _gastosSearch = [];

  @readonly
  List<SangriaModel>? _sangriasSearch = [];

  @readonly
  List<DieselModel>? _dieselSearch = [];

  @readonly
  String? _filterName;

  @readonly
  String? _errorMessage;

  @action
  Future<void> deleteFarm(int id) async {
    try {
      _homeStatus = HomeStateStatus.loading;
      await Future.delayed(Duration.zero);
      await _farmRepository.farmDelete(id);
      await _gastosRepository.deleteAllGastosByFarmId(id);
      await _dieselRepository.deleteAllDieselByFarmId(id);
      await _sangriaRepository.deleteAllSangriaByFarmId(id);
      await getAllFarms();
      await getAllDiesel();
      await getAllGastos();
      await getAllSangrias();
      _homeStatus = HomeStateStatus.farmDeleted;
    } catch (e, s) {
      log('Erro ao excluir fazendas', error: e, stackTrace: s);
      _homeStatus = HomeStateStatus.error;
    }
  }

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
  Future<void> getAllSangrias() async {
    try {
      _homeStatus = HomeStateStatus.loading;
      _sangriasList = await _sangriaRepository.getSangrias(_filterName);
      _sangriasSearch = _sangriasList;
      _homeStatus = HomeStateStatus.success;
    } catch (e, s) {
      log('Erro ao buscar sangrias', error: e, stackTrace: s);
      _homeStatus = HomeStateStatus.error;
      _sangriasList = [];
    }
  }

  @action
  Future<void> getAllDiesel() async {
    try {
      _homeStatus = HomeStateStatus.loading;
      _dieselList = await _dieselRepository.getDiesels(_filterName);
      _dieselSearch = _dieselList;
      _homeStatus = HomeStateStatus.success;
    } catch (e, s) {
      log('Erro ao buscar diesels', error: e, stackTrace: s);
      _homeStatus = HomeStateStatus.error;
      _dieselList = [];
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
      log('Erro ao deletar gastos', error: e, stackTrace: s);
      _homeStatus = HomeStateStatus.error;
    }
  }

  @action
  Future<void> deleteSangria(int id) async {
    try {
      _homeStatus = HomeStateStatus.loading;
      await _sangriaRepository.sangriaDelete(id);
      await getAllFarms();
      _homeStatus = HomeStateStatus.success;
    } catch (e, s) {
      log('Erro ao deletar sangrias', error: e, stackTrace: s);
      _homeStatus = HomeStateStatus.error;
    }
  }

  @action
  Future<void> deleteDiesel(int id) async {
    try {
      _homeStatus = HomeStateStatus.loading;
      await _dieselRepository.dieselDelete(id);
      await getAllFarms();
      _homeStatus = HomeStateStatus.success;
    } catch (e, s) {
      log('Erro ao deletar diesels', error: e, stackTrace: s);
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
  void filterSangriaByName(String name) {
    _sangriasSearch = _sangriasList
        ?.where(
          (p) => (p.destino)
              .trim()
              .toUpperCase()
              .contains(name.trim().toUpperCase()),
        )
        .toList();
  }

  @action
  void filterDieselByName(String name) {
    _dieselSearch = _dieselList
        ?.where(
          (p) => (p.razao)
              .trim()
              .toUpperCase()
              .contains(name.trim().toUpperCase()),
        )
        .toList();
  }

  @action
  void filterGastosByFazenda(int farmId) {
    _gastosSearch =
        _gastosList?.where((gasto) => gasto.farmId == farmId).toList() ?? [];

    // Se a lista estiver vazia, talvez queira também emitir uma mensagem
    if (_gastosSearch!.isEmpty) {
      _errorMessage = "Nenhum gasto encontrado para esta fazenda.";
    } else {
      _errorMessage = null; // Reseta a mensagem de erro se houver resultados
    }
  }

  @action
  void filterSangriaByFazenda(int farmId) {
    _sangriasSearch =
        _sangriasList?.where((sangria) => sangria.farmId == farmId).toList() ??
            [];

    // Se a lista estiver vazia, talvez queira também emitir uma mensagem
    if (_sangriasSearch!.isEmpty) {
      _errorMessage = "Nenhuma sangria encontrada para esta fazenda.";
    } else {
      _errorMessage = null; // Reseta a mensagem de erro se houver resultados
    }
  }

  @action
  void filterDieselByFazenda(int farmId) {
    _dieselSearch =
        _dieselList?.where((diesel) => diesel.farmId == farmId).toList() ?? [];

    // Se a lista estiver vazia, talvez queira também emitir uma mensagem
    if (_dieselSearch!.isEmpty) {
      _errorMessage = "Nenhum diesel encontrado para esta fazenda.";
    } else {
      _errorMessage = null; // Reseta a mensagem de erro se houver resultados
    }
  }
}
