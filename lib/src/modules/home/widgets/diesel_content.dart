import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trab_apsoo/src/modules/diesel/widgets/diesel_item.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';

class DieselContent extends StatefulWidget {
  final HomeController controller;
  final int? selectedFarmId;
  final Function(int?) onFarmSelected;
  const DieselContent(
      {super.key,
      required this.controller,
      this.selectedFarmId,
      required this.onFarmSelected});

  @override
  State<DieselContent> createState() => _DieselContentState();
}

class _DieselContentState extends State<DieselContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (_) {
            return Visibility(
              visible: widget.controller.homeStatus == HomeStateStatus.loading
                  ? false
                  : true,
              replacement: const Center(child: CircularProgressIndicator()),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(),
                    hint: const Text('Filtrar Por Fazenda'),
                    value: widget.selectedFarmId,
                    items: widget.controller.farmList?.map((farm) {
                      return DropdownMenuItem<int>(
                        value: farm.id,
                        child: Text(farm.nome), // Nome da fazenda
                      );
                    }).toList(),
                    onChanged: widget.onFarmSelected,
                    validator: (value) => value == null
                        ? 'Por favor, selecione uma fazenda'
                        : null,
                  ),
                  if (widget.selectedFarmId != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          widget.onFarmSelected(null);
                          widget.controller.getAllDiesel();
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        Observer(
          builder: (_) {
            return Visibility(
              visible: widget.controller.homeStatus == HomeStateStatus.loading
                  ? false
                  : true,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Expanded(
                child: Observer(
                  builder: (_) {
                    return widget.controller.dieselSearch!.isEmpty
                        ? const Center(
                            child: Text('Nenhum diesel encontrado'),
                          )
                        : ListView.builder(
                            itemCount: widget.controller.dieselSearch?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DieselItem(
                                    controller: widget.controller,
                                    diesel:
                                        widget.controller.dieselSearch![index]),
                              );
                            },
                          );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
