import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/repositories/diesel/diesel_repository.dart';
import 'package:trab_apsoo/src/repositories/diesel/diesel_repository_impl.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository_impl.dart';
import 'package:trab_apsoo/src/repositories/gasto/gasto_repository.dart';
import 'package:trab_apsoo/src/repositories/gasto/gasto_repository_impl.dart';
import 'package:trab_apsoo/src/repositories/sangria/sangria_repository.dart';
import 'package:trab_apsoo/src/repositories/sangria/sangria_repository_impl.dart';
import '../core/core_module.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton<PlantsService>(PlantsServiceImpl.new);
    i.addLazySingleton<HomeController>(HomeController.new);
    i.addLazySingleton<FarmRepository>(FarmRepositoryImpl.new);
    i.addLazySingleton<GastoRepository>(GastoRepositoryImpl.new);
    i.addLazySingleton<SangriaRepository>(SangriaRepositoryImpl.new);
    i.addLazySingleton<DieselRepository>(DieselRepositoryImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage());
  }

  @override
  List<Module> get imports => [CoreModule()];
}
