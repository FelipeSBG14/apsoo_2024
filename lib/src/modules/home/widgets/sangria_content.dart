// SangriaContent.dart
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';
import 'package:trab_apsoo/src/modules/sangrias/widgets/sangria_item.dart';

class SangriaContent extends StatefulWidget {
  final HomeController controller;
  final int? selectedFarmId;
  final Function(int?) onFarmSelected;

  const SangriaContent({
    super.key,
    required this.controller,
    required this.selectedFarmId,
    required this.onFarmSelected,
  });

  @override
  State<SangriaContent> createState() => _SangriaContentState();
}

class _SangriaContentState extends State<SangriaContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (_) {
            return Visibility(
              visible: widget.controller.homeStatus != HomeStateStatus.loading,
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
                        child: Text(farm.nome),
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
                          widget.controller
                              .getAllSangrias(); // Restaura a lista completa
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
              visible: widget.controller.homeStatus != HomeStateStatus.loading,
              replacement: const Center(child: CircularProgressIndicator()),
              child: Expanded(
                child: Observer(
                  builder: (_) {
                    return widget.controller.sangriasSearch!.isEmpty
                        ? const Center(
                            child: Text('Nenhuma sangria encontrada'),
                          )
                        : ListView.builder(
                            itemCount: widget.controller.sangriasSearch?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SangriaItem(
                                  controller: widget.controller,
                                  sangria:
                                      widget.controller.sangriasSearch![index],
                                ),
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
