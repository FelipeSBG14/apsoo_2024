import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/core/ui/helpers/currency_formatter.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';

class FarmItem extends StatelessWidget {
  final FarmModel farm;
  const FarmItem({super.key, required this.farm});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Modular.to.pushNamed('/newFarm/farmPage', arguments: farm);
        },
        splashColor: Colors.blueAccent.withOpacity(1),
        highlightColor: Colors.blueAccent.withOpacity(1),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.13,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.12,
                  color: Colors.blueGrey,
                  child: Image.asset(
                    'assets/images/fazenda.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
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
                      const SizedBox(
                        height: 12,
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
