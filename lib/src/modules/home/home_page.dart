import 'package:flutter/material.dart';
import 'package:trab_apsoo/src/core/ui/helpers/size_extensions.dart';
import 'package:trab_apsoo/src/core/widgets/barra_de_acao.dart';
import 'package:trab_apsoo/src/core/widgets/menu_button.dart';
import 'package:trab_apsoo/src/core/widgets/service_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              child: const Column(
                children: [
                  MenuButton(icon: Icons.create_outlined, label: 'Cadastro'),
                  MenuButton(icon: Icons.work, label: 'Fazendas'),
                  MenuButton(icon: Icons.wallet, label: 'Gastos'),
                  MenuButton(icon: Icons.water_drop, label: 'Sangrias')
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                children: [
                  const BarraDeAcao(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.844,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 4 itens por linha
                        mainAxisSpacing: 4.0, // Espaçamento entre linhas
                        crossAxisSpacing: 4.0, // Espaçamento entre colunas
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return const ServiceItem(
                          itemText: 'Teste',
                          value: 10.00,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
