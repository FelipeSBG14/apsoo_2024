import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trab_apsoo/src/core/ui/helpers/date_formatter.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/modules/farms/farm_controller.dart';

Future<void> exportToExcel(
  BuildContext context,
  FarmController controller,
  FarmModel farm,
) async {
  // Carrega o template .xls da pasta assets
  final ByteData data =
      await rootBundle.load('assets/modeloExcel/templateDefinitivo.xlsx');
  final Uint8List bytes = data.buffer.asUint8List();

  // Carrega o arquivo Excel a partir dos bytes
  var excel = Excel.decodeBytes(bytes);

  // Seleciona a primeira planilha do template
  var sheet = excel.sheets[excel.tables.keys.first];

  // Preenche as células com os dados da fazenda
  sheet?.updateCell(
      CellIndex.indexByString("I2"), TextCellValue(farm.nome.toUpperCase()));
  sheet?.updateCell(
      CellIndex.indexByString("B4"), TextCellValue(farm.municipio));
  sheet?.updateCell(
      CellIndex.indexByString("B5"), TextCellValue('${farm.ha} HA'));
  sheet?.updateCell(
      CellIndex.indexByString("B6"), TextCellValue(farm.maquinario));
  sheet?.updateCell(
    CellIndex.indexByString("B7"),
    TextCellValue(
      DateFormatter.format(
        farm.startDate,
      ),
    ),
  );
  sheet?.updateCell(
    CellIndex.indexByString("B8"),
    TextCellValue(
      DateFormatter.format(
        farm.startDate,
      ),
    ),
  );
  sheet?.updateCell(CellIndex.indexByString("B9"), TextCellValue(farm.nfCode!));
  sheet?.updateCell(
      CellIndex.indexByString("B10"), TextCellValue(farm.funcionarios!));
  sheet?.updateCell(
      CellIndex.indexByString("B11"), TextCellValue(farm.servicoName!));
  sheet?.updateCell(
      CellIndex.indexByString("B12"),
      TextCellValue(
        'R\$ ${farm.valorTotal}',
      ));

  // Preenche os dados da tabela de gastos
  int rowIndex =
      3; // Ajuste para a linha inicial onde começa a tabela de gastos

  for (var gasto in controller.gastosByFarm) {
    sheet?.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: rowIndex),
      TextCellValue(
        DateFormatter.format(
          farm.startDate,
        ),
      ),
    ); // DATA
    sheet?.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: rowIndex),
        TextCellValue(gasto.descricao)); // DESCRIÇÃO
    sheet?.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: rowIndex),
        DoubleCellValue(gasto.value)); // VALOR
    rowIndex++;
  }

  // Tabela de DIESEL
  rowIndex = 3; // Pula algumas linhas para a próxima seção

  for (var diesel in controller.dieselByFarm) {
    sheet?.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: rowIndex),
      TextCellValue(
        DateFormatter.format(
          farm.startDate,
        ),
      ),
    );
    sheet?.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: rowIndex),
        TextCellValue(diesel.nfCode)); // assuming NF is integer
    sheet?.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: rowIndex),
        TextCellValue(diesel.razao));
    sheet?.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: rowIndex),
        DoubleCellValue(diesel.value));
    sheet?.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 17, rowIndex: rowIndex),
        IntCellValue(diesel.litros));
    rowIndex++;
  }

  // Tabela de SANGRIA
  rowIndex = 33; // Pula algumas linhas para a próxima seção

  for (var sangria in controller.sangriaByFarm) {
    sheet?.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: rowIndex),
      TextCellValue(
        DateFormatter.format(
          farm.startDate,
        ),
      ),
    );
    sheet?.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: rowIndex),
        IntCellValue(sangria.litros));
    sheet?.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: rowIndex),
        TextCellValue(sangria.destino));
    sheet?.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: rowIndex),
        DoubleCellValue(sangria.valor));
    rowIndex++;
  }
  String filePath = "C:\\excel\\Fazenda_${farm.nome}.xls";
  // Salva o arquivo modificado no diretório de documentos
  final directory = Directory("C:\\excel");
  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }
  final file = File(filePath);
  await file.writeAsBytes(excel.encode()!);

  // Exibe mensagem de sucesso
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text('Arquivo Excel exportado com sucesso para $filePath')),
  );
}
