// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:trab_apsoo/src/models/gastos/diesel_model.dart';
import 'package:trab_apsoo/src/models/gastos/gastos_model.dart';
import 'package:trab_apsoo/src/models/gastos/sangria_model.dart';
import 'package:trab_apsoo/src/models/gastos/servico_model.dart';

class FarmModel {
  final int? id;
  final bool enabled;
  final String nome;
  final String municipio;
  final String maquinario;
  final String? ha;
  final DateTime? startDate;
  final DateTime? finalDate;
  final String? nfCode;
  final String? servicoName;
  final List<ServicoModel>? servico;
  final double? valorTotal;
  final String? funcionarios;
  final List<GastosModel>? gastos;
  final List<DieselModel>? diesel;
  final List<SangriaModel>? sangrias;
  FarmModel({
    this.id,
    required this.enabled,
    required this.nome,
    required this.municipio,
    required this.maquinario,
    this.ha,
    this.startDate,
    this.finalDate,
    this.nfCode,
    this.servicoName,
    this.servico,
    this.valorTotal,
    this.funcionarios,
    this.gastos,
    this.diesel,
    this.sangrias,
  });

  FarmModel copyWith({
    int? id,
    bool? enabled,
    String? nome,
    String? municipio,
    String? maquinario,
    String? ha,
    DateTime? startDate,
    DateTime? finalDate,
    String? nfCode,
    String? servicoName,
    List<ServicoModel>? servico,
    double? valorTotal,
    String? funcionarios,
    List<GastosModel>? gastos,
    List<DieselModel>? diesel,
    List<SangriaModel>? sangrias,
  }) {
    return FarmModel(
      id: id ?? this.id,
      enabled: enabled ?? this.enabled,
      nome: nome ?? this.nome,
      municipio: municipio ?? this.municipio,
      maquinario: maquinario ?? this.maquinario,
      ha: ha ?? this.ha,
      startDate: startDate ?? this.startDate,
      finalDate: finalDate ?? this.finalDate,
      nfCode: nfCode ?? this.nfCode,
      servicoName: servicoName ?? this.servicoName,
      servico: servico ?? this.servico,
      valorTotal: valorTotal ?? this.valorTotal,
      funcionarios: funcionarios ?? this.funcionarios,
      gastos: gastos ?? this.gastos,
      diesel: diesel ?? this.diesel,
      sangrias: sangrias ?? this.sangrias,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'enabled': enabled,
      'nome': nome,
      'municipio': municipio,
      'maquinario': maquinario,
      'ha': ha,
      'startDate': startDate?.millisecondsSinceEpoch,
      'finalDate': finalDate?.millisecondsSinceEpoch,
      'nfCode': nfCode,
      'servicoName': servicoName,
      'servico': servico?.map((x) => x.toMap()).toList(),
      'valorTotal': valorTotal,
      'funcionarios': funcionarios,
      'gastos': gastos?.map((x) => x.toMap()).toList(),
      'diesel': diesel?.map((x) => x.toMap()).toList(),
      'sangrias': sangrias?.map((x) => x.toMap()).toList(),
    };
  }

  factory FarmModel.fromMap(Map<String, dynamic> map) {
    return FarmModel(
      id: map['id'] != null ? map['id'] as int : null,
      enabled: map['enabled'] as bool,
      nome: map['nome'] as String,
      municipio: map['municipio'] as String,
      maquinario: map['maquinario'] as String,
      ha: map['ha'] != null ? map['ha'] as String : null,
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int)
          : null,
      finalDate: map['finalDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['finalDate'] as int)
          : null,
      nfCode: map['nfCode'] as String,
      servicoName:
          map['servicoName'] != null ? map['servicoName'] as String : null,
      servico: map['servico'] != null
          ? List<ServicoModel>.from(
              (map['servico'] as List<int>).map<ServicoModel?>(
                (x) => ServicoModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      valorTotal:
          map['valorTotal'] != null ? map['valorTotal'] as double : null,
      funcionarios:
          map['funcionarios'] != null ? map['funcionarios'] as String : null,
      gastos: map['gastos'] != null
          ? List<GastosModel>.from(
              (map['gastos'] as List<int>).map<GastosModel?>(
                (x) => GastosModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      diesel: map['diesel'] != null
          ? List<DieselModel>.from(
              (map['diesel'] as List<int>).map<DieselModel?>(
                (x) => DieselModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      sangrias: map['sangrias'] != null
          ? List<SangriaModel>.from(
              (map['sangrias'] as List<int>).map<SangriaModel?>(
                (x) => SangriaModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FarmModel.fromJson(String source) =>
      FarmModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
