import 'package:flutter_modular/flutter_modular.dart';
import '../core/core_module.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton<PlantsService>(PlantsServiceImpl.new);
    i.addLazySingleton<HomeController>(HomeController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage());
  }

  @override
  List<Module> get imports => [CoreModule()];
}
