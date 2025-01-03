import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/core/ui/helpers/currency_formatter.dart';
import 'package:trab_apsoo/src/core/ui/helpers/date_formatter.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';
import 'package:trab_apsoo/src/core/widgets/modal_exclusao.dart';
import 'package:trab_apsoo/src/models/gastos/gastos_model.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';

class GastoItem extends StatelessWidget {
  final HomeController controller;
  final GastosModel gasto;
  const GastoItem({super.key, required this.gasto, required this.controller});

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalExclusao(
          message: 'Tem certeza que deseja excluir esse gasto ?',
          onPressed: () async {
            await controller.deleteGasto(gasto.id!);
            await controller.getAllGastos();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(); // Fecha o modal após a confirmação
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.79,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 32.0, right: 10),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        gasto.descricao,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.i.textTitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormatter.format(gasto.date!),
                      style: TextStyles.i.textRegular.copyWith(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Valor: ${formatCurrency(gasto.value)}',
                      style: TextStyles.i.textRegular.copyWith(
                        color: const Color.fromARGB(255, 80, 79, 79),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _showDeleteConfirmation(context);
                      },
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Modular.to.pushNamed('/newGasto/', arguments: gasto);
                        });
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
