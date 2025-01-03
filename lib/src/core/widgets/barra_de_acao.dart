import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/core/ui/helpers/size_extensions.dart';

class BarraDeAcao extends StatelessWidget {
  final int index;
  final Function(String)? onChanged;
  const BarraDeAcao({super.key, this.onChanged, required this.index});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.79,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              width: context.screenWidht * 0.3,
              height: context.screenHeight * 0.3,
              child: TextFormField(
                onChanged: onChanged,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(
                    Icons.search,
                    size: context.screenWidht * 0.02,
                  ),
                  label: const Text('Pesquisar'),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  if (index == 0) {
                    Modular.to.pushNamed('/newFarm/');
                  }
                  if (index == 1) {
                    Modular.to.pushNamed('/newGasto/');
                  }
                  if (index == 2) {
                    Modular.to.pushNamed('/newSangria/');
                  }
                  if (index == 3) {
                    Modular.to.pushNamed('/newDiesel/');
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.black, // Define o fundo do botão como preto
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    'Adicionar',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
