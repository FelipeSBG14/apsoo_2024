import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/core/ui/helpers/currency_formatter.dart';
import 'package:trab_apsoo/src/core/ui/helpers/date_formatter.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';
import 'package:trab_apsoo/src/core/widgets/modal_exclusao.dart';
import 'package:trab_apsoo/src/models/gastos/sangria_model.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';

class SangriaItem extends StatelessWidget {
  final HomeController controller;
  final SangriaModel sangria;
  const SangriaItem(
      {super.key, required this.sangria, required this.controller});

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalExclusao(
          message: 'Tem certeza que deseja excluir essa sangria ?',
          onPressed: () async {
            await controller.deleteSangria(sangria.id!);
            await controller.getAllSangrias();
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 32.0, right: 15),
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
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          "Destino: ${sangria.destino}",
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
                        DateFormatter.format(sangria.date!),
                        style: TextStyles.i.textRegular.copyWith(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Litros: ${sangria.litros}',
                        style: TextStyles.i.textRegular.copyWith(
                          color: const Color.fromARGB(255, 80, 79, 79),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Valor: ${formatCurrency(sangria.valor)}',
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
                          Modular.to
                              .pushNamed('/newSangria/', arguments: sangria);
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
