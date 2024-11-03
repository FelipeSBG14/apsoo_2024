import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:trab_apsoo/src/core/exceptions/repository_exception.dart';
import 'package:trab_apsoo/src/core/interceptors/custom_dio.dart';
import 'package:trab_apsoo/src/models/gastos/gastos_model.dart';
import 'package:trab_apsoo/src/repositories/gasto/gasto_repository.dart';

class GastoRepositoryImpl implements GastoRepository {
  final CustomDio _dio;

  GastoRepositoryImpl(this._dio);
  @override
  Future<void> addOrEditGastos(GastosModel gasto) async {
    try {
      if (gasto.id != null) {
        await _dio.put(
          '/gastos/${gasto.id}',
          data: gasto.toMap(),
        );
      } else {
        await _dio.post(
          '/gastos',
          data: gasto.toMap(),
        );
      }
    } on DioException catch (e, s) {
      log('Erro ao salvar ou editar o gasto', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao salvar ou editar o gasto: ${e.message}');
    }
  }

  @override
  Future<void> gastoDelete(id) async {
    try {
      await _dio.delete(
        '/gastos/$id',
      );
    } on DioException catch (e, s) {
      log('Erro ao deletar produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar produto');
    }
  }

  @override
  Future<List<GastosModel>> getGastos(String? descricao) async {
    try {
      List<GastosModel> gastosList = [];
      final response = await _dio.get(
        '/gastos',
        queryParameters: {
          if (descricao != null) 'descricao': descricao,
        },
      );
      gastosList = (response.data)
          .map<GastosModel>((farmData) =>
              GastosModel.fromMap(farmData as Map<String, dynamic>))
          .toList();
      return gastosList;
    } on DioException catch (e, s) {
      log('Erro ao buscar gastos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar gastos');
    } catch (e, s) {
      log('Erro desconhecido ao buscar gastos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar gastos');
    }
  }
}