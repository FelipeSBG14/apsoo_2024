import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/modules/core/core_module.dart';
import 'package:trab_apsoo/src/modules/gastos/gasto_add_page.dart';
import 'package:trab_apsoo/src/modules/gastos/gasto_controller.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository_impl.dart';
import 'package:trab_apsoo/src/repositories/gasto/gasto_repository.dart';
import 'package:trab_apsoo/src/repositories/gasto/gasto_repository_impl.dart';

class GastoModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<GastoRepository>(GastoRepositoryImpl.new);
    i.addLazySingleton<GastoController>(GastoController.new);
    i.addLazySingleton<FarmRepository>(FarmRepositoryImpl.new);
    i.addLazySingleton<HomeController>(HomeController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const GastoAddPage());
  }

  @override
  List<Module> get imports => [
        CoreModule(),
      ];
}
