import 'package:flutter/material.dart';
import 'package:trab_apsoo/src/core/ui/helpers/size_extensions.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';
import 'package:trab_apsoo/src/core/widgets/farm_input.dart';
import 'package:validatorless/validatorless.dart';

class FarmAddPage extends StatefulWidget {
  const FarmAddPage({super.key});

  @override
  State<FarmAddPage> createState() => _FarmAddPageState();
}

class _FarmAddPageState extends State<FarmAddPage> {
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
    super.dispose();
  }

  void _submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      final startDate = DateTime.parse(startDateEC.text);
      final endDate = DateTime.parse(finalDateEC.text);

      // Verifica se a data de início é menor que a data final
      if (startDate.isAfter(endDate)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('A data de início deve ser anterior à data final.')),
        );
        return;
      }

      // Processar os dados do formulário
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulário enviado com sucesso!')),
      );
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
        title: const Text('Adicionar Fazenda'),
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
                          child: FarmInput(
                            label: 'Nome da Fazenda',
                            hint: 'Insira o Nome da Fazenda',
                            controller: nomeEC,
                            validator:
                                Validatorless.required('Campo Obrigatório'),
                          ),
                        ),
                        SizedBox(
                          width: context.screenWidht * 0.4,
                          child: FarmInput(
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
                    FarmInput(
                      label: 'Maquinário',
                      hint: 'Insira o Maquinário',
                      controller: maquinarioEC,
                      validator: Validatorless.required(
                        'Campo Obrigatório',
                      ),
                    ),
                    const SizedBox(height: 30),
                    FarmInput(
                      label: 'Hectares',
                      hint: 'Insira a área em hectares',
                      controller: haEC,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => _selectDate(startDateEC),
                      child: AbsorbPointer(
                        child: FarmInput(
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
                        child: FarmInput(
                          label: 'Data Final',
                          hint: 'Insira a Data Final',
                          controller: finalDateEC,
                          validator:
                              Validatorless.required('Campo Obrigatório'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    FarmInput(
                      label: 'Código NF',
                      hint: 'Insira o Código da Nota Fiscal',
                      controller: nfCodeEC,
                    ),
                    const SizedBox(height: 30),
                    FarmInput(
                      label: 'Serviço',
                      hint: 'Insira o Nome do Serviço',
                      controller: servicoNameEC,
                    ),
                    const SizedBox(height: 30),
                    FarmInput(
                      label: 'Valor Total',
                      hint: 'Insira o Valor Total',
                      controller: valorTotalEC,
                      prefixIcon: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'R\$',
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    FarmInput(
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
