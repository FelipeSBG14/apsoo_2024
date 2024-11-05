import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/core/ui/helpers/debouncer.dart';
import 'package:trab_apsoo/src/core/ui/helpers/loaders.dart';
import 'package:trab_apsoo/src/core/ui/helpers/messages.dart';
import 'package:trab_apsoo/src/core/ui/helpers/size_extensions.dart';
import 'package:trab_apsoo/src/core/widgets/barra_de_acao.dart';
import 'package:trab_apsoo/src/core/widgets/menu_button.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';
import 'package:trab_apsoo/src/modules/home/widgets/diesel_content.dart';
import 'package:trab_apsoo/src/modules/home/widgets/farm_content.dart';
import 'package:trab_apsoo/src/modules/home/widgets/gastos_content.dart';
import 'package:trab_apsoo/src/modules/home/widgets/sangria_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  int _selectedIndex = 0; // Inicia na opção "Fazendas"
  bool isVisible = false;
  final controller = Modular.get<HomeController>();
  int? selectedFarmId;
  final debouncer = Debouncer(milisencods: 200);
  late final ReactionDisposer statusDisposer;

  // Função para definir o índice selecionado
  void _onMenuButtonPressed(int index) {
    setState(() {
      controller.getAllFarms();
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.getAllFarms().then((_) {
      controller.getAllGastos();
      controller.getAllSangrias();
      controller.getAllDiesel();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusDisposer = reaction(
        (_) => controller.homeStatus,
        (status) async {
          switch (status) {
            case HomeStateStatus.inital:
              break;
            case HomeStateStatus.loading:
              showLoader();
              break;
            case HomeStateStatus.success:
              hideLoader();
            case HomeStateStatus.uploaded:
              break;
            case HomeStateStatus.loaded:
              hideLoader();
            case HomeStateStatus.addOrEdit:
              break;
            case HomeStateStatus.error:
              showError('Erro ao buscar fazendas');
              hideLoader();
            case HomeStateStatus.farmDeleted:
              showSuccess('Sucesso ao excluir fazenda');
              hideLoader();
              break;
          }
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WA GESTÃO'),
      ),
      body: SizedBox(
        width: context.screenWidht * 1,
        height: context.screenLongestSide,
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: context.screenWidht * 0.2,
              height: context.screenHeight * 1,
              child: Column(
                children: [
                  MenuButton(
                    icon: Icons.work,
                    label: 'Fazendas',
                    isSelected: _selectedIndex == 0,
                    onPressed: () => _onMenuButtonPressed(0),
                  ),
                  MenuButton(
                    icon: Icons.wallet,
                    label: 'Gastos',
                    isSelected: _selectedIndex == 1,
                    onPressed: () => _onMenuButtonPressed(1),
                  ),
                  MenuButton(
                    icon: Icons.water_drop,
                    label: 'Sangrias',
                    isSelected: _selectedIndex == 2,
                    onPressed: () => _onMenuButtonPressed(2),
                  ),
                  MenuButton(
                    icon: Icons.gas_meter,
                    label: 'Diesel',
                    isSelected: _selectedIndex == 3,
                    onPressed: () => _onMenuButtonPressed(3),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  BarraDeAcao(
                    index: _selectedIndex,
                    onChanged: (value) {
                      debouncer.call(
                        () {
                          if (_selectedIndex == 0) {
                            controller.filterFarmByName(value);
                          }
                          if (_selectedIndex == 1) {
                            controller.filterGastoByName(value);
                          }
                          if (_selectedIndex == 2) {
                            controller.filterSangriaByName(value);
                          }
                          if (_selectedIndex == 3) {
                            controller.filterDieselByName(value);
                          }
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: [
                        FarmContent(
                          controller: controller,
                        ),
                        GastosContent(
                          controller: controller,
                          selectedFarmId: selectedFarmId,
                          onFarmSelected: (int? value) {
                            setState(() {
                              selectedFarmId = value;
                              if (value != null) {
                                controller.filterGastosByFazenda(value);
                              } else {
                                controller
                                    .getAllGastos(); // Restaura a lista completa
                              }
                            });
                          },
                        ),
                        SangriaContent(
                          controller: controller,
                          selectedFarmId: selectedFarmId,
                          onFarmSelected: (int? value) {
                            setState(() {
                              selectedFarmId = value;
                              if (value != null) {
                                controller.filterSangriaByFazenda(value);
                              } else {
                                controller
                                    .getAllSangrias(); // Restaura a lista completa
                              }
                            });
                          },
                        ),
                        DieselContent(
                          controller: controller,
                          selectedFarmId: selectedFarmId,
                          onFarmSelected: (int? value) {
                            setState(() {
                              selectedFarmId = value;
                              if (value != null) {
                                controller.filterDieselByFazenda(value);
                              } else {
                                controller
                                    .getAllDiesel(); // Restaura a lista completa
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
