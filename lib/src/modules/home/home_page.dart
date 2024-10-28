import 'package:flutter/material.dart';
import 'package:trab_apsoo/src/core/ui/helpers/size_extensions.dart';
import 'package:trab_apsoo/src/core/widgets/barra_de_acao.dart';
import 'package:trab_apsoo/src/core/widgets/menu_button.dart';
import 'package:trab_apsoo/src/core/widgets/service_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Inicia na opção "Fazendas"

  // Função para definir o índice selecionado
  void _onMenuButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                children: [
                  const BarraDeAcao(),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: [
                        _buildCadastroContent(),
                        _buildFazendasContent(),
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

  Widget _buildFazendasContent() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return const ServiceItem(
          itemText: 'Fazenda',
          value: 10.00,
        );
      },
    );
  }

  Widget _buildGastosContent() {
    return const Center(child: Text("Conteúdo de Gastos"));
  }

  Widget _buildSangriasContent() {
    return const Center(child: Text("Conteúdo de Sangrias"));
  }
}
