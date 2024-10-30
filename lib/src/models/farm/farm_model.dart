// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

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
          ? (map['startDate'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int)
              : DateTime.tryParse(map['startDate']))
          : null,
      finalDate: map['finalDate'] != null
          ? (map['finalDate'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['finalDate'] as int)
              : DateTime.tryParse(map['finalDate']))
          : null,
      nfCode: map['nfCode'] != null ? map['nfCode'] as String : null,
      servicoName:
          map['servicoName'] != null ? map['servicoName'] as String : null,
      servico: map['servico'] != null
          ? List<ServicoModel>.from(
              (map['servico'] as List<dynamic>).map<ServicoModel?>(
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
              (map['gastos'] as List<dynamic>).map<GastosModel?>(
                (x) => GastosModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      diesel: map['diesel'] != null
          ? List<DieselModel>.from(
              (map['diesel'] as List<dynamic>).map<DieselModel?>(
                (x) => DieselModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      sangrias: map['sangrias'] != null
          ? List<SangriaModel>.from(
              (map['sangrias'] as List<dynamic>).map<SangriaModel?>(
                (x) => SangriaModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FarmModel.fromJson(String source) =>
      FarmModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FarmModel(id: $id, enabled: $enabled, nome: $nome, municipio: $municipio, maquinario: $maquinario, ha: $ha, startDate: $startDate, finalDate: $finalDate, nfCode: $nfCode, servicoName: $servicoName, servico: $servico, valorTotal: $valorTotal, funcionarios: $funcionarios, gastos: $gastos, diesel: $diesel, sangrias: $sangrias)';
  }

  @override
  bool operator ==(covariant FarmModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.enabled == enabled &&
        other.nome == nome &&
        other.municipio == municipio &&
        other.maquinario == maquinario &&
        other.ha == ha &&
        other.startDate == startDate &&
        other.finalDate == finalDate &&
        other.nfCode == nfCode &&
        other.servicoName == servicoName &&
        listEquals(other.servico, servico) &&
        other.valorTotal == valorTotal &&
        other.funcionarios == funcionarios &&
        listEquals(other.gastos, gastos) &&
        listEquals(other.diesel, diesel) &&
        listEquals(other.sangrias, sangrias);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        enabled.hashCode ^
        nome.hashCode ^
        municipio.hashCode ^
        maquinario.hashCode ^
        ha.hashCode ^
        startDate.hashCode ^
        finalDate.hashCode ^
        nfCode.hashCode ^
        servicoName.hashCode ^
        servico.hashCode ^
        valorTotal.hashCode ^
        funcionarios.hashCode ^
        gastos.hashCode ^
        diesel.hashCode ^
        sangrias.hashCode;
  }
}
