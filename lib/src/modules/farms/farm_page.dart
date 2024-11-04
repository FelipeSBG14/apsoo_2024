import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/core/ui/helpers/currency_formatter.dart';
import 'package:trab_apsoo/src/core/ui/helpers/loaders.dart';
import 'package:trab_apsoo/src/core/ui/helpers/messages.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/modules/farms/farm_controller.dart';
import 'package:trab_apsoo/src/modules/farms/widgets/diesel_section.dart';
import 'package:trab_apsoo/src/modules/farms/widgets/gastos_section.dart';
import 'package:trab_apsoo/src/modules/farms/widgets/sangria_section.dart';

class FarmPage extends StatefulWidget {
  const FarmPage({super.key});

  @override
  State<FarmPage> createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> with Loader, Messages {
  final FarmModel? farm = Modular.args.data;
  final controller = Modular.get<FarmController>();

  @override
  void initState() {
    super.initState();
    controller.loadGastosByFarmId(farm!.id);
    controller.loadDieselByFarmId(farm!.id);
    controller.loadSangriasByFarmId(farm!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Fazenda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome e Localização da Fazenda
              Text(
                farm!.nome,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    farm!.municipio,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Valor Total da Fazenda
              Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_money, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Valor Total do Serviço na Fazenda: ${formatCurrency(farm!.valorTotal)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Observer(
                builder: (_) {
                  double totalGastos = controller.gastosByFarm
                      .fold(0, (sum, gasto) => sum + gasto.value);
                  double totalDiesel = controller.dieselByFarm
                      .fold(0, (sum, diesel) => sum + diesel.value);
                  double totalSangria = controller.sangriaByFarm
                      .fold(0, (sum, sangria) => sum + sangria.valor);
                  double lucroTotal = (farm!.valorTotal ?? 0) -
                      totalGastos -
                      (totalDiesel - totalSangria);
                  return Card(
                    color: lucroTotal > 0
                        ? const Color.fromARGB(255, 138, 233, 166)
                        : const Color.fromARGB(255, 238, 138, 138),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          lucroTotal > 0
                              ? const Icon(Icons.attach_money,
                                  color: Colors.green)
                              : const Icon(
                                  Icons.attach_money,
                                  color: Colors.red,
                                ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Lucro Total do Serviço na Fazenda: ${formatCurrency(lucroTotal)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              GastosSection(controller: controller, farm: farm!),
              const SizedBox(height: 16),
              DieselSection(controller: controller, farm: farm!),
              const SizedBox(height: 16),
              SangriasSection(controller: controller, farm: farm!),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
