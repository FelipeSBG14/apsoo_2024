import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/core/interceptors/custom_dio.dart';
import 'package:trab_apsoo/src/repositories/diesel/diesel_repository.dart';
import 'package:trab_apsoo/src/repositories/diesel/diesel_repository_impl.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository_impl.dart';
import 'package:trab_apsoo/src/repositories/gasto/gasto_repository.dart';
import 'package:trab_apsoo/src/repositories/gasto/gasto_repository_impl.dart';
import 'package:trab_apsoo/src/repositories/sangria/sangria_repository.dart';
import 'package:trab_apsoo/src/repositories/sangria/sangria_repository_impl.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<FarmRepository>(FarmRepositoryImpl.new);
    i.addLazySingleton<GastoRepository>(GastoRepositoryImpl.new);
    i.addLazySingleton<SangriaRepository>(SangriaRepositoryImpl.new);
    i.addLazySingleton<DieselRepository>(DieselRepositoryImpl.new);
    i.addLazySingleton(CustomDio.new);
  }
}
