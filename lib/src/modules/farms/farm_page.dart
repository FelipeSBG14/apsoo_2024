import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/core/ui/helpers/excel.dart';
import 'package:trab_apsoo/src/core/ui/helpers/loaders.dart';
import 'package:trab_apsoo/src/core/ui/helpers/messages.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/modules/farms/farm_controller.dart';

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
                          'Valor Total do Serviço na Fazenda: R\$ ${farm!.valorTotal?.toStringAsFixed(2)}',
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
              const SizedBox(height: 16),

              // Gastos Section
              _buildGastosSection(),

              const SizedBox(height: 16),

              // Diesel Section
              _buildDieselSection(),

              const SizedBox(height: 16),

              // Sangrias Section
              _buildSangriasSection(),

              const SizedBox(height: 16),

              // Botão para voltar
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

  Widget _buildGastosSection() {
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
                      subtitle:
                          Text('Valor: R\$ ${gasto.value.toStringAsFixed(2)}'),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Total Gastos: R\$ ${totalGastos.toStringAsFixed(2)}',
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

  Widget _buildDieselSection() {
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
                      subtitle:
                          Text('Valor: R\$ ${diesel.value.toStringAsFixed(2)}'),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Total Diesel: R\$ ${totalDiesel.toStringAsFixed(2)}',
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

  Widget _buildSangriasSection() {
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
                      subtitle: Text(
                          'Valor: R\$ ${sangria.valor.toStringAsFixed(2)}'),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Total Sangria: R\$ ${totalSangria.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        ),
        ElevatedButton(
          onPressed: () async {
            await exportToExcel(context, controller, farm!);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Define o fundo do botão para verde
            foregroundColor: Colors.white, // Define a cor do texto para branco
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Bordas arredondadas
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min, // Para ajustar ao conteúdo
            children: [
              Icon(
                Icons
                    .description, // Ícone padrão que mais se assemelha ao Excel
                color: Colors.white,
              ),
              SizedBox(width: 8), // Espaçamento entre o ícone e o texto
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
