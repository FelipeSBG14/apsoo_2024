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
  int _selectedIndex = 1; // Inicia na opção "Fazendas"
  final controller = Modular.get<HomeController>();
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
    controller.getAllFarms();
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
                      icon: Icons.create_outlined,
                      label: 'Cadastro',
                      onPressed: () => _onMenuButtonPressed(0),
                    ),
                    MenuButton(
                      icon: Icons.work,
                      label: 'Fazendas',
                      onPressed: () => _onMenuButtonPressed(1),
                    ),
                    MenuButton(
                      icon: Icons.wallet,
                      label: 'Gastos',
                      onPressed: () => _onMenuButtonPressed(2),
                    ),
                    MenuButton(
                      icon: Icons.water_drop,
                      label: 'Sangrias',
                      onPressed: () => _onMenuButtonPressed(3),
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
                    onChanged: (value) {
                      debouncer.call(
                        () {
                          controller.filterByName(value);
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: [
                        _buildCadastroContent(),
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
  Widget _buildCadastroContent() {
    return const Center(child: Text("Conteúdo de Cadastro"));
  }

  Widget _buildGastosContent() {
    return const GastoItem();
  }

  Widget _buildSangriasContent() {
    return const Center(child: Text("Conteúdo de Sangrias"));
  }
}
