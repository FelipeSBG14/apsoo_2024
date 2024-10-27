import 'package:flutter/material.dart';
import 'package:trab_apsoo/src/core/ui/helpers/size_extensions.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';
import 'package:trab_apsoo/src/core/widgets/barra_de_acao.dart';
import 'package:trab_apsoo/src/core/widgets/menu_button.dart';

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
                    child: Center(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                            border: Border.all(color: Colors.grey),
                          ),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.13,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Text',
                                        style: context.textStyles.textRegular
                                            .copyWith(
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        'R\$0,00',
                                        style: context.textStyles.textRegular
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
