import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DieselModel {
  final int? id;
  final int farmId;
  final DateTime? date;
  final String nfCode;
  final String razao;
  final double value;
  final int litros;
  DieselModel({
    this.id,
    required this.farmId,
    this.date,
    required this.nfCode,
    required this.razao,
    required this.value,
    required this.litros,
  });

  DieselModel copyWith({
    int? id,
    int? farmId,
    DateTime? date,
    String? nfCode,
    String? razao,
    double? value,
    int? litros,
  }) {
    return DieselModel(
      id: id ?? this.id,
      farmId: id ?? this.farmId,
      date: date ?? this.date,
      nfCode: nfCode ?? this.nfCode,
      razao: razao ?? this.razao,
      value: value ?? this.value,
      litros: litros ?? this.litros,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'farmId': farmId,
      'date': date?.millisecondsSinceEpoch,
      'nfCode': nfCode,
      'razao': razao,
      'value': value,
      'litros': litros,
    };
  }

  factory DieselModel.fromMap(Map<String, dynamic> map) {
    return DieselModel(
      id: map['id'] != null ? map['id'] as int : null,
      farmId: map['farmId'] as int,
      date: map['date'] != null
          ? (map['date'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
              : DateTime.tryParse(map['date']))
          : null,
      nfCode: map['nfCode'] as String,
      razao: map['razao'] as String,
      value: map['value'] as double,
      litros: map['litros'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DieselModel.fromJson(String source) =>
      DieselModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
