import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:trab_apsoo/src/core/ui/helpers/decimal_formatter.dart';
import 'package:trab_apsoo/src/core/ui/helpers/loaders.dart';
import 'package:trab_apsoo/src/core/ui/helpers/messages.dart';
import 'package:trab_apsoo/src/core/ui/helpers/size_extensions.dart';
import 'package:trab_apsoo/src/core/widgets/general_input.dart';
import 'package:trab_apsoo/src/modules/farms/farm_controller.dart';
import 'package:trab_apsoo/src/modules/home/home_controller.dart';
import 'package:validatorless/validatorless.dart';

import '../../models/farm/farm_model.dart';

class FarmAddPage extends StatefulWidget {
  const FarmAddPage({super.key});

  @override
  State<FarmAddPage> createState() => _FarmAddPageState();
}

class _FarmAddPageState extends State<FarmAddPage> with Loader, Messages {
  final controller = Modular.get<FarmController>();
  final homeController = Modular.get<HomeController>();
  int? farmId;
  bool isEditing = false;
  late final ReactionDisposer statusDisposer;
  final formKey = GlobalKey<FormState>();
  final enabledEC = TextEditingController();
  final nomeEC = TextEditingController();
  final municipioEC = TextEditingController();
  final maquinarioEC = TextEditingController();
  final haEC = TextEditingController();
  final startDateEC = TextEditingController();
  final finalDateEC = TextEditingController();
  final nfCodeEC = TextEditingController();
  final servicoNameEC = TextEditingController();
  final valorTotalEC = TextEditingController();
  final funcionariosEC = TextEditingController();

  @override
  void dispose() {
    enabledEC.dispose();
    nomeEC.dispose();
    municipioEC.dispose();
    maquinarioEC.dispose();
    haEC.dispose();
    startDateEC.dispose();
    finalDateEC.dispose();
    nfCodeEC.dispose();
    servicoNameEC.dispose();
    valorTotalEC.dispose();
    funcionariosEC.dispose();
    statusDisposer();
    super.dispose();
  }

  @override
  void initState() {
    final FarmModel? farms = Modular.args.data;

    if (farms != null) {
      isEditing = true;
      farmId = farms.id;
      nomeEC.text = farms.nome;
      municipioEC.text = farms.municipio;
      maquinarioEC.text = farms.maquinario;
      haEC.text = farms.ha!;
      startDateEC.text = farms.startDate!.toIso8601String().split('T')[0];
      finalDateEC.text = farms.finalDate!.toIso8601String().split('T')[0];
      nfCodeEC.text = farms.nfCode!;
      servicoNameEC.text = farms.servicoName!;
      valorTotalEC.text = farms.valorTotal.toString();
      funcionariosEC.text = farms.funcionarios!;
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        statusDisposer = reaction(
          (_) => controller.status,
          (status) async {
            switch (status) {
              case FarmStateStatus.inital:
                break;
              case FarmStateStatus.loading:
                showLoader();
                break;
              case FarmStateStatus.loaded:
                hideLoader();
                break;
              case FarmStateStatus.error:
                showError('Erro ao buscar fazenda');
                hideLoader();
                break;
              case FarmStateStatus.addOrUpdateFarm:
                isEditing
                    ? showSuccess('Fazenda editada com sucesso !')
                    : showSuccess('Fazenda adicionada com sucesso !');
                homeController.getAllFarms();
                hideLoader();
                break;
            }
          },
        );
        //controller.loadFarms();
      },
    );
    super.initState();
  }

  void _submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      final startDate = DateTime.parse(startDateEC.text);
      final endDate = DateTime.parse(finalDateEC.text);

      // Verifica se a data de início é menor que a data final
      if (startDate.isAfter(endDate)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A data de início deve ser anterior à data final.'),
          ),
        );

        return;
      }

      // Cria o modelo FarmModel com os dados do formulário
      final farm = FarmModel(
        id: farmId,
        nome: nomeEC.text,
        enabled: true,
        municipio: municipioEC.text,
        maquinario: maquinarioEC.text,
        ha: haEC.text,
        startDate: startDate,
        finalDate: endDate,
        nfCode: nfCodeEC.text,
        servicoName: servicoNameEC.text,
        valorTotal: double.tryParse(valorTotalEC.text),
        funcionarios: funcionariosEC.text,
        // Adicione outras propriedades conforme necessário
      );

      // Chama o método addFarm na controller
      controller.addFarm(farm);

      // Feedback de sucesso ao usuário
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
            ? const Text('Editar Fazenda')
            : const Text('Adicionar Fazenda'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: context.screenWidht * 0.3,
                          child: GeneralInput(
                            label: 'Nome da Fazenda',
                            hint: 'Insira o Nome da Fazenda',
                            controller: nomeEC,
                            validator:
                                Validatorless.required('Campo Obrigatório'),
                          ),
                        ),
                        SizedBox(
                          width: context.screenWidht * 0.4,
                          child: GeneralInput(
                            label: 'Município',
                            hint: 'Insira o Município',
                            controller: municipioEC,
                            validator: Validatorless.required(
                              'Campo Obrigatório',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    GeneralInput(
                      label: 'Maquinário',
                      hint: 'Insira o Maquinário',
                      controller: maquinarioEC,
                      validator: Validatorless.required(
                        'Campo Obrigatório',
                      ),
                    ),
                    const SizedBox(height: 30),
                    GeneralInput(
                      label: 'Hectares',
                      hint: 'Insira a área em hectares',
                      controller: haEC,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => _selectDate(startDateEC),
                      child: AbsorbPointer(
                        child: GeneralInput(
                          label: 'Data de Início',
                          hint: 'Insira a Data de Início',
                          controller: startDateEC,
                          validator:
                              Validatorless.required('Campo Obrigatório'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => _selectDate(finalDateEC),
                      child: AbsorbPointer(
                        child: GeneralInput(
                          label: 'Data Final',
                          hint: 'Insira a Data Final',
                          controller: finalDateEC,
                          validator:
                              Validatorless.required('Campo Obrigatório'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GeneralInput(
                      label: 'Código NF',
                      hint: 'Insira o Código da Nota Fiscal',
                      controller: nfCodeEC,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    const SizedBox(height: 30),
                    GeneralInput(
                      label: 'Serviço',
                      hint: 'Insira o Nome do Serviço',
                      controller: servicoNameEC,
                    ),
                    const SizedBox(height: 30),
                    GeneralInput(
                      label: 'Valor Total',
                      hint: 'Insira o Valor Total',
                      inputType: TextInputType.number,
                      controller: valorTotalEC,
                      inputFormatters: [decimalInputFormatter()],
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(top: 10, left: 8),
                        child: Text(
                          'R\$',
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GeneralInput(
                      label: 'Funcionários',
                      hint: 'Insira os Nomes dos Funcionários',
                      controller: funcionariosEC,
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
