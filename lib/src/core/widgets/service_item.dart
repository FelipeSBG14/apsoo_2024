import 'package:flutter/material.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';

class ServiceItem extends StatelessWidget {
  final String itemText;
  final double value;
  const ServiceItem({super.key, required this.itemText, required this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {},
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
          height: MediaQuery.of(context).size.height * 0.30,
          width: MediaQuery.of(context).size.width * 0.13,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width * 0.12,
                  color: Colors.blueGrey,
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
                        itemText,
                        style: context.textStyles.textRegular.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'R\$ $value',
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
