import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServicoModel {
  final int? id;
  final String name;
  final double valor;
  ServicoModel({
    this.id,
    required this.name,
    required this.valor,
  });

  ServicoModel copyWith({
    int? id,
    String? name,
    double? valor,
  }) {
    return ServicoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      valor: valor ?? this.valor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'valor': valor,
    };
  }

  factory ServicoModel.fromMap(Map<String, dynamic> map) {
    return ServicoModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      valor: map['valor'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServicoModel.fromJson(String source) =>
      ServicoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
