import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/modules/farms/farm_module.dart';
import 'package:trab_apsoo/src/modules/home/home_module.dart';
import 'modules/core/core_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];
  @override
  void routes(RouteManager r) {
    r.module('/', module: HomeModule());
    r.module('/newFarm', module: FarmModule());
    //r.module('/listPlants/', module: ListPlantsModule());
  }
}
