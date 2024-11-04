import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Carrega todos os dados necessários para a HomePage
    await controller.getAllFarms();
    await controller.getAllGastos();
    await controller.getAllSangrias();
    await controller.getAllDiesel();

    // Após carregar os dados, navegue para a HomePage
    Modular.to.pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Carregando dados, por favor, aguarde...'),
          ],
        ),
      ),
    );
  }
}
