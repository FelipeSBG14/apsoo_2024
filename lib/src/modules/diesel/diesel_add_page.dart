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
import 'package:trab_apsoo/src/models/gastos/diesel_model.dart';
import 'package:trab_apsoo/src/modules/diesel/diesel_controller.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';
import 'package:validatorless/validatorless.dart';

class DieselAddPage extends StatefulWidget {
  const DieselAddPage({super.key});

  @override
  State<DieselAddPage> createState() => _DieselAddPageState();
}

class _DieselAddPageState extends State<DieselAddPage> with Loader, Messages {
  final controller = Modular.get<DieselController>();
  final homeController = Modular.get<HomeController>();

  bool isEditing = false;
  int? selectedFarmId;
  late final ReactionDisposer statusDisposer;
  int? dieselId;
  final formKey = GlobalKey<FormState>();
  final nfCodeEC = TextEditingController();
  final razaoEC = TextEditingController();
  final dataEC = TextEditingController();
  final valorEC = TextEditingController();
  final litrosEC = TextEditingController();

  @override
  void dispose() {
    razaoEC.dispose();
    dataEC.dispose();
    valorEC.dispose();
    statusDisposer();
    super.dispose();
  }

  @override
  void initState() {
    controller.loadFarms();
    final DieselModel? diesel = Modular.args.data;

    // ignore: unnecessary_null_comparison
    if (diesel != null) {
      isEditing = true;
      dieselId = diesel.id;
      selectedFarmId = diesel.farmId;
      razaoEC.text = diesel.razao;
      nfCodeEC.text = diesel.nfCode;
      dataEC.text =
          diesel.date!.toIso8601String().split('T')[0]; // Formato "yyyy-mm-dd"
      valorEC.text = diesel.value.toString();
      litrosEC.text = diesel.litros.toString();
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        statusDisposer = reaction((_) => controller.status, (status) async {
          switch (status) {
            case DieselStateStatus.inital:
              break;
            case DieselStateStatus.loading:
              showLoader();
              break;
            case DieselStateStatus.loaded:
              hideLoader();
              break;
            case DieselStateStatus.error:
              showError('Erro ao buscar diesel');
              hideLoader();
              break;
            case DieselStateStatus.addOrUpdateDiesel:
              isEditing
                  ? showSuccess('Diesel editado com sucesso')
                  : showSuccess('Diesel adicionado com sucesso');
              homeController.getAllDiesel();
              hideLoader();
              Navigator.of(context, rootNavigator: true).pop();
              break;
          }
        });
      },
    );
    super.initState();
  }

  void _submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      final date = DateTime.parse(dataEC.text);

      // Verifica se a data de início é menor que a data final

      // Cria o modelo DieselModel com os dados do formulário
      final diesel = DieselModel(
        id: dieselId,
        farmId: selectedFarmId!,
        razao: razaoEC.text,
        nfCode: nfCodeEC.text,
        date: date,
        value: double.tryParse(valorEC.text) ?? 0.0,
        litros: int.tryParse(litrosEC.text) ?? 0,
        // Adicione outras propriedades conforme necessário
      );

      // Chama o método addDiesel na controller
      controller.addDiesel(diesel);
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
            ? const Text('Editar Diesel')
            : const Text('Adicionar Diesel'),
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
                                  controller.status == DieselStateStatus.loading
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
                            hint: 'Insira o Valor do Diesel',
                            inputFormatters: [decimalInputFormatter()],
                            inputType: TextInputType.number,
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
                    const SizedBox(
                      height: 30,
                    ),
                    GeneralInput(
                      label: 'Código da Nota Fiscal',
                      hint: 'Insira o código da nota fiscal de compra',
                      inputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: Validatorless.required('Campo Obrigatório'),
                      controller: nfCodeEC,
                    ),
                    const SizedBox(height: 30),
                    GeneralInput(
                      label: 'Razão',
                      lines: 5,
                      maxLines: 50,
                      hint: 'Insira a razao desse Diesel',
                      controller: razaoEC,
                      validator: Validatorless.required(
                        'Campo Obrigatório',
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: context.screenWidht * 0.4,
                      child: GeneralInput(
                        label: 'Litros de Diesel',
                        hint: 'Insira os litros de Diesel',
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
