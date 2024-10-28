// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:trab_apsoo/src/core/exceptions/repository_exception.dart';
import 'package:trab_apsoo/src/core/interceptors/custom_dio.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/repositories/farm/farm_repository.dart';

class FarmRepositoryImpl implements FarmRepository {
  final CustomDio _dio;

  FarmRepositoryImpl(
    this._dio,
  );

  @override
  Future<void> addOrEditFarms(FarmModel farm) async {
    try {
      if (farm.id != null) {
        await _dio.put(
          '/farm/${farm.id}',
          data: farm.toMap(),
        );
      } else {
        await _dio.post(
          '/farm',
          data: farm.toMap(),
        );
      }
    } on DioException catch (e, s) {
      log('Erro ao salvar ou editar a fazenda', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao salvar ou editar a fazenda: ${e.message}');
    }
  }

  @override
  Future<void> farmDelete(id) async {
    try {
      await _dio.put(
        '/farm/$id',
        data: {
          'enabled': false,
        },
      );
    } on DioException catch (e, s) {
      log('Erro ao inativar fazenda', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao inativar a fazenda: ${e.message}');
    }
  }

  @override
  Future<List<FarmModel>> getFarms(String? nome) async {
    try {
      final farmResult = await _dio.get(
        '/farm',
        queryParameters: {
          if (nome != null) 'name': nome,
          'enabled': true,
        },
      );
      return farmResult.data
          .map<FarmModel>((p) => FarmModel.fromMap(p))
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar fazendas', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao buscar fazendas: ${e.message}');
    }
  }
}
