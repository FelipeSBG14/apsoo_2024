import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trab_apsoo/src/core/ui/helpers/currency_formatter.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/modules/farms/farm_controller.dart';

class DieselSection extends StatelessWidget {
  final FarmController controller;
  final FarmModel farm;
  const DieselSection(
      {super.key, required this.controller, required this.farm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Diesel',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const Divider(),
        Observer(
          builder: (_) {
            if (controller.dieselByFarm.isEmpty) {
              return const Text('Nenhum diesel registrado para esta fazenda.');
            }
            double totalDiesel = controller.dieselByFarm
                .fold(0, (sum, diesel) => sum + diesel.value);

            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.dieselByFarm.length,
                  itemBuilder: (context, index) {
                    final diesel = controller.dieselByFarm[index];
                    return ListTile(
                      title: Text(diesel.razao),
                      subtitle: Text('Valor: ${formatCurrency(diesel.value)}'),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Total Diesel: ${formatCurrency(totalDiesel)}',
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
