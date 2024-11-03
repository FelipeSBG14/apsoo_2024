import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServicoModel {
  final int? id;
  final int farmId;
  final String name;
  final double valor;
  ServicoModel({
    this.id,
    required this.farmId,
    required this.name,
    required this.valor,
  });

  ServicoModel copyWith({
    int? id,
    int? farmId,
    String? name,
    double? valor,
  }) {
    return ServicoModel(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      name: name ?? this.name,
      valor: valor ?? this.valor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'farmId': farmId,
      'name': name,
      'valor': valor,
    };
  }

  factory ServicoModel.fromMap(Map<String, dynamic> map) {
    return ServicoModel(
      id: map['id'] != null ? map['id'] as int : null,
      farmId: map['farmId'] as int,
      name: map['name'] as String,
      valor: map['valor'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServicoModel.fromJson(String source) =>
      ServicoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
