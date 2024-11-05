import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:trab_apsoo/src/core/exceptions/repository_exception.dart';
import 'package:trab_apsoo/src/core/interceptors/custom_dio.dart';
import 'package:trab_apsoo/src/models/gastos/diesel_model.dart';
import 'package:trab_apsoo/src/repositories/diesel/diesel_repository.dart';

class DieselRepositoryImpl implements DieselRepository {
  final CustomDio _dio;

  DieselRepositoryImpl(this._dio);
  @override
  Future<void> addOrEditDiesel(DieselModel diesel) async {
    try {
      if (diesel.id != null) {
        await _dio.put(
          '/diesel/${diesel.id}',
          data: diesel.toMap(),
        );
      } else {
        await _dio.post(
          '/diesel',
          data: diesel.toMap(),
        );
      }
    } on DioException catch (e, s) {
      log('Erro ao salvar ou editar o diesel', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao salvar ou editar o diesel: ${e.message}');
    }
  }

  @override
  Future<void> deleteAllDieselByFarmId(int farmId) async {
    try {
      // Busca todos os registros de diesel relacionados à fazenda pelo farmId
      final dieselList = await getDieselByFarmId(farmId);

      // Verifica se há registros para deletar
      if (dieselList.isEmpty) {
        log('Nenhum diesel encontrado para a fazenda com ID $farmId');
        return;
      }

      // Itera sobre a lista e deleta cada item individualmente
      for (var diesel in dieselList) {
        await dieselDelete(diesel.id);
      }
      log('Todos os registros de diesel para a fazenda $farmId foram deletados com sucesso.');
    } on DioException catch (e, s) {
      log('Erro ao deletar todos os registros de diesel por farmId',
          error: e, stackTrace: s);
      throw RepositoryException(
        message:
            'Erro ao deletar todos os registros de diesel por farmId: ${e.message}',
      );
    } catch (e, s) {
      log('Erro desconhecido ao deletar registros de diesel',
          error: e, stackTrace: s);
      throw RepositoryException(
        message:
            'Erro ao deletar registros de diesel para a fazenda com ID $farmId',
      );
    }
  }

  @override
  Future<void> dieselDelete(id) async {
    try {
      await _dio.delete(
        '/diesel/$id',
      );
    } on DioException catch (e, s) {
      log('Erro ao deletar diesel', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar diesel');
    }
  }

  @override
  Future<List<DieselModel>> getDiesels(String? destino) async {
    try {
      List<DieselModel> dieselList = [];
      final response = await _dio.get(
        '/diesel',
        queryParameters: {
          if (destino != null) 'destino': destino,
        },
      );
      dieselList = (response.data)
          .map<DieselModel>((farmData) =>
              DieselModel.fromMap(farmData as Map<String, dynamic>))
          .toList();
      return dieselList;
    } on DioException catch (e, s) {
      log('Erro ao buscar diesels', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar diesels');
    } catch (e, s) {
      log('Erro desconhecido ao buscar diesels', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar diesels');
    }
  }

  @override
  Future<List<DieselModel>> getDieselByFarmId(int? farmId) async {
    try {
      final response = await _dio.get(
        '/diesel',
        queryParameters: {
          'farmId': farmId,
        },
      );
      return (response.data as List)
          .map((dieselData) => DieselModel.fromMap(dieselData))
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar diesel por farmId', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar diesel por farmId');
    }
  }
}
