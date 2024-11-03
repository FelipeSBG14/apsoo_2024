import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/modules/farms/farm_controller.dart';

Future<void> exportToExcel(
  BuildContext context,
  FarmController controller,
  FarmModel farm,
) async {
  // Cria uma instância de Excel
  var excel = Excel.createExcel();
  var sheet = excel['Relatório Fazenda'];

  // Informações do cabeçalho
  sheet.appendRow([
    TextCellValue('Município:'),
    TextCellValue('Início: ${farm.startDate} ${farm.municipio}')
  ]);
  sheet.appendRow([TextCellValue('A/C:'), TextCellValue('${farm.maquinario}')]);
  sheet.appendRow([TextCellValue('${farm.ha}HA')]);
  sheet.appendRow([TextCellValue('Fim: ${farm.finalDate}')]);
  sheet.appendRow([
    TextCellValue('NF: ${farm.nfCode}'),
    TextCellValue('Funcionários:${farm.funcionarios}')
  ]);

  sheet.appendRow([TextCellValue('')]); // Linha vazia
  sheet.appendRow([TextCellValue('SERVIÇO: ${farm.servico}')]);

  sheet.appendRow([TextCellValue('')]); // Linha vazia
  sheet.appendRow([TextCellValue('TOTAL R\$ ${farm.valorTotal}')]); // Total

  sheet.appendRow([TextCellValue('')]); // Linha vazia

  // Seção "FAZENDA SANTA CECÍLIA - GILMAR"
  sheet.appendRow([
    TextCellValue('${farm.nome.toUpperCase()}'),
    TextCellValue(''),
    TextCellValue(''),
  ]);
  sheet.appendRow([
    TextCellValue('DATA'),
    TextCellValue('DESCRIÇÃO'),
    TextCellValue('VALOR'),
  ]);

  for (var gasto in controller.gastosByFarm) {
    sheet.appendRow([
      TextCellValue(gasto.date.toString()),
      TextCellValue(gasto.descricao),
      DoubleCellValue(gasto.value),
    ]);
  }

  sheet.appendRow([TextCellValue('')]); // Linha vazia

  // Seção "DIESEL"
  sheet.appendRow([TextCellValue('DIESEL')]);
  sheet.appendRow([
    TextCellValue('DATA'),
    TextCellValue('NF'),
    TextCellValue('RAZÃO'),
    TextCellValue('VALOR'),
    TextCellValue('LITROS')
  ]);

  for (var diesel in controller.dieselByFarm) {
    sheet.appendRow([
      TextCellValue(diesel.date.toString()),
      TextCellValue(diesel.nfCode),
      TextCellValue(diesel.razao),
      DoubleCellValue(diesel.value),
      IntCellValue(diesel.litros),
    ]);
  }

  sheet.appendRow([TextCellValue('')]); // Linha vazia

  // Seção "SANGRIA"
  sheet.appendRow([TextCellValue('SANGRIA')]);
  sheet.appendRow([
    TextCellValue('DATA'),
    TextCellValue('LITROS'),
    TextCellValue('PARA ONDE FOI'),
    TextCellValue('VALOR'),
  ]);

  for (var sangria in controller.sangriaByFarm) {
    sheet.appendRow([
      TextCellValue(sangria.date.toString()),
      IntCellValue(sangria.litros),
      TextCellValue(sangria.destino),
      DoubleCellValue(sangria.valor),
    ]);
  }

  // Salva o arquivo no diretório de documentos
  var directory = await getApplicationDocumentsDirectory();
  String filePath = "${directory.path}/Fazenda_${farm.nome}.xlsx";
  var fileBytes = excel.save();
  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);

  // Exibe mensagem de sucesso
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text('Arquivo Excel exportado com sucesso para $filePath')),
  );
}
