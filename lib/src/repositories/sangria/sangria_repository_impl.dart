import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:trab_apsoo/src/core/exceptions/repository_exception.dart';
import 'package:trab_apsoo/src/core/interceptors/custom_dio.dart';
import 'package:trab_apsoo/src/models/gastos/sangria_model.dart';
import 'package:trab_apsoo/src/repositories/sangria/sangria_repository.dart';

class SangriaRepositoryImpl implements SangriaRepository {
  final CustomDio _dio;

  SangriaRepositoryImpl(this._dio);
  @override
  Future<void> addOrEditSangrias(SangriaModel sangria) async {
    try {
      if (sangria.id != null) {
        await _dio.put(
          '/sangria/${sangria.id}',
          data: sangria.toMap(),
        );
      } else {
        await _dio.post(
          '/sangria',
          data: sangria.toMap(),
        );
      }
    } on DioException catch (e, s) {
      log('Erro ao salvar ou editar o sangria', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao salvar ou editar o sangria: ${e.message}');
    }
  }

  @override
  Future<void> sangriaDelete(id) async {
    try {
      await _dio.delete(
        '/sangria/$id',
      );
    } on DioException catch (e, s) {
      log('Erro ao deletar sangria', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar sangria');
    }
  }

  @override
  Future<List<SangriaModel>> getSangrias(String? destino) async {
    try {
      List<SangriaModel> sangriaList = [];
      final response = await _dio.get(
        '/sangria',
        queryParameters: {
          if (destino != null) 'destino': destino,
        },
      );
      sangriaList = (response.data)
          .map<SangriaModel>((farmData) =>
              SangriaModel.fromMap(farmData as Map<String, dynamic>))
          .toList();
      return sangriaList;
    } on DioException catch (e, s) {
      log('Erro ao buscar Sangrias', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar Sangrias');
    } catch (e, s) {
      log('Erro desconhecido ao buscar Sangrias', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar Sangrias');
    }
  }

  @override
  Future<List<SangriaModel>> getSangriaByFarmId(int? farmId) async {
    try {
      final response = await _dio.get(
        '/sangria',
        queryParameters: {
          'farmId': farmId,
        },
      );
      return (response.data as List)
          .map((sangriaData) => SangriaModel.fromMap(sangriaData))
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar sangria por farmId', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar sangria por farmId');
    }
  }
}
