import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trab_apsoo/src/modules/farms/widgets/farm_item.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';

class FarmContent extends StatefulWidget {
  final HomeController controller;
  const FarmContent({
    super.key,
    required this.controller,
  });

  @override
  State<FarmContent> createState() => _FarmContentState();
}

class _FarmContentState extends State<FarmContent> {
  @override
  Widget build(BuildContext context) {
    return Observer(
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
                return widget.controller.farmSearch!.isEmpty
                    ? const Center(
                        child: Text('Nenhuma fazenda encontrada'),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                        itemCount: widget.controller.farmSearch?.length,
                        itemBuilder: (context, index) {
                          return FarmItem(
                            farm: widget.controller.farmSearch![index],
                          );
                        },
                      );
              },
            ),
          ),
        );
      },
    );
  }
}
