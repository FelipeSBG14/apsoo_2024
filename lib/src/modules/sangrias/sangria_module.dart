import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/modules/core/core_module.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';
import 'package:trab_apsoo/src/modules/sangrias/sangria_add_page.dart';
import 'package:trab_apsoo/src/modules/sangrias/sangria_controller.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository_impl.dart';
import 'package:trab_apsoo/src/repositories/sangria/sangria_repository.dart';
import 'package:trab_apsoo/src/repositories/sangria/sangria_repository_impl.dart';

class SangriaModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<SangriaRepository>(SangriaRepositoryImpl.new);
    i.addLazySingleton<SangriaController>(SangriaController.new);
    i.addLazySingleton<FarmRepository>(FarmRepositoryImpl.new);
    i.addLazySingleton<HomeController>(HomeController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const SangriaAddPage());
  }

  @override
  List<Module> get imports => [
        CoreModule(),
      ];
}
