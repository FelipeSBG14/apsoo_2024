// SangriasSection.dart
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trab_apsoo/src/core/ui/helpers/currency_formatter.dart';
import 'package:trab_apsoo/src/core/ui/helpers/excel.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/modules/farms/farm_controller.dart';

class SangriasSection extends StatelessWidget {
  final FarmController controller;
  final FarmModel farm;

  const SangriasSection({
    super.key,
    required this.controller,
    required this.farm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sangrias',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const Divider(),
        Observer(
          builder: (_) {
            if (controller.sangriaByFarm.isEmpty) {
              return const Text(
                  'Nenhuma sangria registrada para esta fazenda.');
            }
            double totalSangria = controller.sangriaByFarm
                .fold(0, (sum, sangria) => sum + sangria.valor);

            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.sangriaByFarm.length,
                  itemBuilder: (context, index) {
                    final sangria = controller.sangriaByFarm[index];
                    return ListTile(
                      title: Text(sangria.destino),
                      subtitle: Text('Valor: ${formatCurrency(sangria.valor)}'),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Total Sangria: ${formatCurrency(totalSangria)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        ),
        ElevatedButton(
          onPressed: () async {
            await exportToExcel(context, controller, farm);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.description, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Gerar Excel',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
