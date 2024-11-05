import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/core/ui/helpers/currency_formatter.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';

class FarmItem extends StatelessWidget {
  final FarmModel farm;
  FarmItem({super.key, required this.farm});

  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/newFarm/farmPage', arguments: farm);
      },
      onLongPress: () {
        _showOptionsModal(context);
      },
      splashColor: Colors.blueAccent.withOpacity(1),
      highlightColor: Colors.blueAccent.withOpacity(1),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Imagem da fazenda
            AspectRatio(
              aspectRatio: 16 / 10, // Mantém uma proporção mais estável
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/fazenda.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Nome e informações da fazenda
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        farm.nome,
                        overflow: TextOverflow.ellipsis,
                        style: context.textStyles.textRegular.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Valor do Serviço',
                        style: context.textStyles.textRegular.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        formatCurrency(farm.valorTotal),
                        style: context.textStyles.textRegular.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar'),
              onTap: () {
                Navigator.of(context).pop(); // Fecha o modal
                Modular.to.pushNamed('/newFarm/', arguments: farm);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever_outlined),
              title: const Text('Excluir'),
              onTap: () {
                Navigator.of(context).pop();
                _showDeleteConfirmationDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancelar'),
              onTap: () {
                Navigator.of(context).pop(); // Fecha o modal
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmar Exclusão',
            style: TextStyles.i.textRegular.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Tem certeza de que deseja excluir esta fazenda? Essa ação não pode ser desfeita e excluirá também os gastos, sangrias e diesel dessa fazenda !',
            style: TextStyles.i.textRegular,
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await controller.deleteFarm(farm.id!);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(); // Fecha o diálogo de confirmação
                // Ação de exclusão da fazenda aqui
              },
            ),
          ],
        );
      },
    );
  }
}
