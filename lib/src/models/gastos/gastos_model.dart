import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GastosModel {
  final int? id;
  final DateTime? date;
  final String descricao;
  final double value;
  GastosModel({
    this.id,
    this.date,
    required this.descricao,
    required this.value,
  });

  GastosModel copyWith({
    int? id,
    DateTime? date,
    String? descricao,
    double? value,
  }) {
    return GastosModel(
      id: id ?? this.id,
      date: date ?? this.date,
      descricao: descricao ?? this.descricao,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date?.millisecondsSinceEpoch,
      'descricao': descricao,
      'value': value,
    };
  }

  factory GastosModel.fromMap(Map<String, dynamic> map) {
    return GastosModel(
      id: map['id'] != null ? map['id'] as int : null,
      date: map['date'] != null
          ? (map['date'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
              : DateTime.tryParse(map['date']))
          : null,
      descricao: map['descricao'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory GastosModel.fromJson(String source) =>
      GastosModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
