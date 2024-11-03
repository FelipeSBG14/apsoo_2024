import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/core/ui/helpers/debouncer.dart';
import 'package:trab_apsoo/src/core/ui/helpers/loaders.dart';
import 'package:trab_apsoo/src/core/ui/helpers/messages.dart';
import 'package:trab_apsoo/src/core/ui/helpers/size_extensions.dart';
import 'package:trab_apsoo/src/core/widgets/barra_de_acao.dart';
import 'package:trab_apsoo/src/core/widgets/menu_button.dart';
import 'package:trab_apsoo/src/modules/farms/widgets/farm_item.dart';
import 'package:trab_apsoo/src/modules/gastos/widgets/gasto_item.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';

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

  bool _isVisible(int index) {
    setState(() {
      if (index == 0) {
        isVisible = false;
      }
      if (index == 1) {
        isVisible = true;
      }
      if (index == 2) {
        isVisible = false;
      }
    });
    return isVisible;
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
            Flexible(
              flex: 2,
              child: Container(
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
                  ],
                ),
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
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: [
                        Observer(
                          builder: (_) {
                            return Visibility(
                              visible: controller.homeStatus ==
                                      HomeStateStatus.loading
                                  ? false
                                  : true,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: Expanded(
                                child: Observer(
                                  builder: (_) {
                                    return controller.farmSearch!.isEmpty
                                        ? const Center(
                                            child: Text(
                                                'Nenhuma fazenda encontrada'),
                                          )
                                        : GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              mainAxisSpacing: 4.0,
                                              crossAxisSpacing: 4.0,
                                            ),
                                            itemCount:
                                                controller.farmSearch?.length,
                                            itemBuilder: (context, index) {
                                              return FarmItem(
                                                  farm: controller
                                                      .farmSearch![index]);
                                            },
                                          );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        _buildGastosContent(),
                        _buildSangriasContent(),
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

  // Conteúdo para cada botão do menu

  Widget _buildGastosContent() {
    return Column(
      children: [
        Observer(
          builder: (_) {
            return Visibility(
              visible: controller.homeStatus == HomeStateStatus.loading
                  ? false
                  : true,
              replacement: const Center(child: CircularProgressIndicator()),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(),
                    hint: const Text('Filtrar Por Fazenda'),
                    value: selectedFarmId,
                    items: controller.farmList?.map((farm) {
                      return DropdownMenuItem<int>(
                        value: farm.id,
                        child: Text(farm.nome), // Nome da fazenda
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        selectedFarmId = value;
                        if (value != null) {
                          controller.filterByFazenda(value);
                        } else {
                          controller
                              .getAllGastos(); // Restaura a lista completa
                        }
                      });
                    },
                    validator: (value) => value == null
                        ? 'Por favor, selecione uma fazenda'
                        : null,
                  ),
                  if (selectedFarmId != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            selectedFarmId = null;
                            controller
                                .getAllGastos(); // Restaura a lista completa
                          });
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        Observer(
          builder: (_) {
            return Visibility(
              visible: controller.homeStatus == HomeStateStatus.loading
                  ? false
                  : true,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Expanded(
                child: Observer(
                  builder: (_) {
                    return controller.gastosSearch!.isEmpty
                        ? const Center(
                            child: Text('Nenhum gasto encontrado'),
                          )
                        : ListView.builder(
                            itemCount: controller.gastosSearch?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GastoItem(
                                    controller: controller,
                                    gasto: controller.gastosSearch![index]),
                              );
                            },
                          );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSangriasContent() {
    return const Center(child: Text("Conteúdo de Sangrias"));
  }
}
