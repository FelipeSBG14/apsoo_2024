import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/core/ui/helpers/decimal_formatter.dart';
import 'package:trab_apsoo/src/core/ui/helpers/loaders.dart';
import 'package:trab_apsoo/src/core/ui/helpers/messages.dart';
import 'package:trab_apsoo/src/core/ui/helpers/size_extensions.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';
import 'package:trab_apsoo/src/core/widgets/general_input.dart';
import 'package:trab_apsoo/src/models/gastos/gastos_model.dart';
import 'package:trab_apsoo/src/modules/gastos/gasto_controller.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';
import 'package:validatorless/validatorless.dart';

class GastoAddPage extends StatefulWidget {
  const GastoAddPage({super.key});

  @override
  State<GastoAddPage> createState() => _GastoAddPageState();
}

class _GastoAddPageState extends State<GastoAddPage> with Loader, Messages {
  final controller = Modular.get<GastoController>();
  final homeController = Modular.get<HomeController>();

  int? selectedFarmId;
  late final ReactionDisposer statusDisposer;
  int? gastoId;
  final formKey = GlobalKey<FormState>();
  final descricaoEC = TextEditingController();
  final dataEC = TextEditingController();
  final valorEC = TextEditingController();
  bool isEditing = false;

  @override
  void dispose() {
    descricaoEC.dispose();
    dataEC.dispose();
    valorEC.dispose();
    statusDisposer();
    super.dispose();
  }

  @override
  void initState() {
    controller.loadFarms();
    final GastosModel? gastos = Modular.args.data;

    if (gastos != null) {
      isEditing = true;
      gastoId = gastos.id;
      selectedFarmId = gastos.farmId;
      descricaoEC.text = gastos.descricao;
      dataEC.text =
          gastos.date!.toIso8601String().split('T')[0]; // Formato "yyyy-mm-dd"
      valorEC.text = gastos.value.toString();
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        statusDisposer = reaction((_) => controller.status, (status) async {
          switch (status) {
            case GastoStateStatus.inital:
              break;
            case GastoStateStatus.loading:
              showLoader();
              break;
            case GastoStateStatus.loaded:
              hideLoader();
              break;
            case GastoStateStatus.error:
              showError('Erro ao buscar gasto');
              hideLoader();
              break;
            case GastoStateStatus.addOrUpdateGasto:
              isEditing
                  ? showSuccess('Gasto editado com sucesso !')
                  : showSuccess('Gasto adicionado com sucesso !');
              homeController.getAllGastos();
              hideLoader();
              Navigator.of(context, rootNavigator: true).pop();
              break;
          }
        });
        //controller.loadgastos();
      },
    );
    super.initState();
  }

  void _submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      final date = DateTime.parse(dataEC.text);

      // Verifica se a data de início é menor que a data final

      // Cria o modelo GastosModel com os dados do formulário
      final gasto = GastosModel(
        id: gastoId,
        farmId: selectedFarmId!,
        descricao: descricaoEC.text,
        date: date,
        value: double.tryParse(valorEC.text) ?? 0.0,
        // Adicione outras propriedades conforme necessário
      );

      // Chama o método addgasto na controller
      controller.addGasto(gasto);
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      controller.text = "${selectedDate.toLocal()}"
          .split(' ')[0]; // Formata para "yyyy-mm-dd"
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEditing
            ? const Text('Editar Gasto')
            : const Text('Adicionar Gastos'),
      ),
      body: Center(
        child: Container(
          width: context.screenWidht * 0.9,
          height: context.screenHeight * 0.9,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Selecione a Fazenda',
                            style: context.textStyles.textRegular.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Observer(
                          builder: (_) {
                            return Visibility(
                              visible:
                                  controller.status == GastoStateStatus.loading
                                      ? false
                                      : true,
                              replacement: const Center(
                                  child: CircularProgressIndicator()),
                              child: DropdownButtonFormField<int>(
                                decoration: const InputDecoration(),
                                value: selectedFarmId,
                                items: controller.farms.map((farm) {
                                  return DropdownMenuItem<int>(
                                    value: farm.id,
                                    child: Text(farm.nome), // Nome da fazenda
                                  );
                                }).toList(),
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedFarmId = value;
                                  });
                                },
                                validator: (value) => value == null
                                    ? 'Por favor, selecione uma fazenda'
                                    : null,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: context.screenWidht * 0.3,
                          child: GestureDetector(
                            onTap: () => _selectDate(dataEC),
                            child: AbsorbPointer(
                              child: GeneralInput(
                                label: 'Data',
                                hint: 'Insira a Data',
                                controller: dataEC,
                                validator:
                                    Validatorless.required('Campo Obrigatório'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.screenWidht * 0.4,
                          child: GeneralInput(
                            label: 'Valor',
                            hint: 'Insira o Valor do Gasto',
                            inputType: TextInputType.number,
                            inputFormatters: [
                              decimalInputFormatter(),
                            ],
                            validator:
                                Validatorless.required('Campo Obrigatório'),
                            controller: valorEC,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(top: 10, left: 8),
                              child: Text(
                                'R\$',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    GeneralInput(
                      label: 'Descrição',
                      lines: 5,
                      maxLines: 50,
                      hint: 'Insira a Descrição desse gasto',
                      controller: descricaoEC,
                      validator: Validatorless.required(
                        'Campo Obrigatório',
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Enviar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
