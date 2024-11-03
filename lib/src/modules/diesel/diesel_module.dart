import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/modules/core/core_module.dart';
import 'package:trab_apsoo/src/modules/diesel/diesel_add_page.dart';
import 'package:trab_apsoo/src/modules/diesel/diesel_controller.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';
import 'package:trab_apsoo/src/repositories/diesel/diesel_repository.dart';
import 'package:trab_apsoo/src/repositories/diesel/diesel_repository_impl.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository_impl.dart';

class DieselModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<DieselRepository>(DieselRepositoryImpl.new);
    i.addLazySingleton<DieselController>(DieselController.new);
    i.addLazySingleton<FarmRepository>(FarmRepositoryImpl.new);
    i.addLazySingleton<HomeController>(HomeController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const DieselAddPage());
  }

  @override
  List<Module> get imports => [
        CoreModule(),
      ];
}
