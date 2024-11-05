import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/core/ui/helpers/decimal_formatter.dart';
import 'package:trab_apsoo/src/core/ui/helpers/loaders.dart';
import 'package:trab_apsoo/src/core/ui/helpers/messages.dart';
import 'package:trab_apsoo/src/core/ui/helpers/size_extensions.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';
import 'package:trab_apsoo/src/core/widgets/general_input.dart';
import 'package:trab_apsoo/src/models/gastos/sangria_model.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';
import 'package:trab_apsoo/src/modules/sangrias/sangria_controller.dart';
import 'package:validatorless/validatorless.dart';

class SangriaAddPage extends StatefulWidget {
  const SangriaAddPage({super.key});

  @override
  State<SangriaAddPage> createState() => _SangriaAddPageState();
}

class _SangriaAddPageState extends State<SangriaAddPage> with Loader, Messages {
  final controller = Modular.get<SangriaController>();
  final homeController = Modular.get<HomeController>();

  int? selectedFarmId;
  late final ReactionDisposer statusDisposer;
  int? sangriaId;
  bool isEditing = false;
  final formKey = GlobalKey<FormState>();
  final destinoEC = TextEditingController();
  final dataEC = TextEditingController();
  final valorEC = TextEditingController();
  final litrosEC = TextEditingController();

  @override
  void dispose() {
    destinoEC.dispose();
    dataEC.dispose();
    valorEC.dispose();
    statusDisposer();
    super.dispose();
  }

  @override
  void initState() {
    controller.loadFarms();
    final SangriaModel? sangrias = Modular.args.data;

    // ignore: unnecessary_null_comparison
    if (sangrias != null) {
      isEditing = true;
      sangriaId = sangrias.id;
      selectedFarmId = sangrias.farmId;
      destinoEC.text = sangrias.destino;
      dataEC.text = sangrias.date!
          .toIso8601String()
          .split('T')[0]; // Formato "yyyy-mm-dd"
      valorEC.text = sangrias.valor.toString();
      litrosEC.text = sangrias.litros.toString();
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        statusDisposer = reaction((_) => controller.status, (status) async {
          switch (status) {
            case SangriaStateStatus.inital:
              break;
            case SangriaStateStatus.loading:
              showLoader();
              break;
            case SangriaStateStatus.loaded:
              hideLoader();
              break;
            case SangriaStateStatus.error:
              showError('Erro ao buscar sangria');
              hideLoader();
              break;
            case SangriaStateStatus.addOrUpdateSangria:
              isEditing
                  ? showSuccess('Sangria editada com sucesso !')
                  : showSuccess('Sangria adicionada com sucesso !');
              homeController.getAllSangrias();
              hideLoader();
              Navigator.of(context, rootNavigator: true).pop();
              break;
          }
        });
        //controller.loadSangrias();
      },
    );
    super.initState();
  }

  void _submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      final date = DateTime.parse(dataEC.text);

      // Verifica se a data de início é menor que a data final

      // Cria o modelo SangriaModel com os dados do formulário
      final sangria = SangriaModel(
        id: sangriaId,
        farmId: selectedFarmId!,
        destino: destinoEC.text,
        date: date,
        valor: double.tryParse(valorEC.text) ?? 0.0,
        litros: int.tryParse(litrosEC.text) ?? 0,
        // Adicione outras propriedades conforme necessário
      );

      // Chama o método aadSangria na controller
      controller.addSangria(sangria);
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
            ? const Text('Editar Sangria')
            : const Text('Adicionar Sangrias'),
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
                              visible: controller.status ==
                                      SangriaStateStatus.loading
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
                            hint: 'Insira o Valor da Sangria',
                            inputType: TextInputType.number,
                            inputFormatters: [decimalInputFormatter()],
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
                      label: 'Destino',
                      lines: 5,
                      maxLines: 50,
                      hint: 'Insira o Destino dessa Sangria',
                      controller: destinoEC,
                      validator: Validatorless.required(
                        'Campo Obrigatório',
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: context.screenWidht * 0.4,
                      child: GeneralInput(
                        label: 'Litros de Sangria',
                        hint: 'Insira os litros economizados',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        inputType: TextInputType.number,
                        validator: Validatorless.required('Campo Obrigatório'),
                        controller: litrosEC,
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
