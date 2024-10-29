import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
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
  HomeControllerBase(
    this._farmRepository,
  );
  @readonly
  HomeStateStatus _homeStatus = HomeStateStatus.inital;

  @observable
  bool isLoading = false;

  @readonly
  List<FarmModel>? _farmList;

  @readonly
  List<FarmModel>? _farmSearch;

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
}
