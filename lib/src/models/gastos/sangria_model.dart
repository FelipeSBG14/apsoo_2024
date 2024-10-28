import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SangriaModel {
  final int? id;
  final DateTime date;
  final int litros;
  final String destino;
  final double valor;
  SangriaModel({
    this.id,
    required this.date,
    required this.litros,
    required this.destino,
    required this.valor,
  });

  SangriaModel copyWith({
    int? id,
    DateTime? date,
    int? litros,
    String? destino,
    double? valor,
  }) {
    return SangriaModel(
      id: id ?? this.id,
      date: date ?? this.date,
      litros: litros ?? this.litros,
      destino: destino ?? this.destino,
      valor: valor ?? this.valor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'litros': litros,
      'destino': destino,
      'valor': valor,
    };
  }

  factory SangriaModel.fromMap(Map<String, dynamic> map) {
    return SangriaModel(
      id: map['id'] != null ? map['id'] as int : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      litros: map['litros'] as int,
      destino: map['destino'] as String,
      valor: map['valor'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SangriaModel.fromJson(String source) =>
      SangriaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}