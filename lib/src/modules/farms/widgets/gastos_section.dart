import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trab_apsoo/src/core/ui/helpers/currency_formatter.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/modules/farms/farm_controller.dart';

class GastosSection extends StatelessWidget {
  final FarmController controller;
  final FarmModel farm;

  const GastosSection(
      {super.key, required this.controller, required this.farm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gastos',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const Divider(),
        Observer(
          builder: (_) {
            if (controller.gastosByFarm.isEmpty) {
              return const Text('Nenhum gasto registrado para esta fazenda.');
            }
            double totalGastos = controller.gastosByFarm
                .fold(0, (sum, gasto) => sum + gasto.value);

            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.gastosByFarm.length,
                  itemBuilder: (context, index) {
                    final gasto = controller.gastosByFarm[index];
                    return ListTile(
                      title: Text(gasto.descricao),
                      subtitle: Text('Valor: ${formatCurrency(gasto.value)}'),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Total Gastos: ${formatCurrency(totalGastos)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
