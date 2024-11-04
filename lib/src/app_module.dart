import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/modules/diesel/diesel_module.dart';
import 'package:trab_apsoo/src/modules/farms/farm_module.dart';
import 'package:trab_apsoo/src/modules/gastos/gasto_module.dart';
import 'package:trab_apsoo/src/modules/home/home_module.dart';
import 'package:trab_apsoo/src/modules/sangrias/sangria_module.dart';
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
    r.module('/newGasto', module: GastoModule());
    r.module('/newSangria', module: SangriaModule());
    r.module('/newDiesel', module: DieselModule());
  }
}
