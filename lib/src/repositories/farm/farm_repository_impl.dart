// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:trab_apsoo/src/core/exceptions/repository_exception.dart';
import 'package:trab_apsoo/src/core/interceptors/custom_dio.dart';
import 'package:trab_apsoo/src/models/farm/farm_model.dart';
import 'package:trab_apsoo/src/models/gastos/diesel_model.dart';
import 'package:trab_apsoo/src/models/gastos/gastos_model.dart';
import 'package:trab_apsoo/src/models/gastos/sangria_model.dart';
import 'package:trab_apsoo/src/models/gastos/servico_model.dart';
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
      final List<FarmModel> _farmsList = [];
      final response = await _dio.get(
        '/farm',
        queryParameters: {
          if (nome != null) 'name': nome,
          'enabled': true,
        },
      );

      print('VAAAAAAAAAAAAAI CURINTIAAAAAAAAAAAAAAAA ${response.data}');

      if (response.data != null) {
        response.data.forEach((farmData) {
          print('Processando fazenda ID: ${farmData['id']}');

          _farmsList.add(
            FarmModel(
              id: farmData['id'] != null ? farmData['id'] as int : null,
              enabled: farmData['enabled'] as bool,
              nome: farmData['nome'] as String,
              municipio: farmData['municipio'] as String,
              maquinario: farmData['maquinario'] as String,
              ha: farmData['ha'] != null ? farmData['ha'] as String : null,
              startDate: farmData['startDate'] != null
                  ? (farmData['startDate'] is int
                      ? DateTime.fromMillisecondsSinceEpoch(
                          farmData['startDate'] as int)
                      : DateTime.parse(farmData['startDate'] as String))
                  : null,
              finalDate: farmData['finalDate'] != null
                  ? (farmData['finalDate'] is int
                      ? DateTime.fromMillisecondsSinceEpoch(
                          farmData['finalDate'] as int)
                      : DateTime.parse(farmData['finalDate'] as String))
                  : null,
              nfCode: farmData['nfCode'] != null
                  ? farmData['nfCode'] as String
                  : null,
              servicoName: farmData['servicoName'] != null
                  ? farmData['servicoName'] as String
                  : null,
              valorTotal: farmData['valorTotal'] != null
                  ? farmData['valorTotal'] as double
                  : null,
              funcionarios: farmData['funcionarios'] != null
                  ? farmData['funcionarios'] as String
                  : null,
            ),
          );
        });
      }
      return _farmsList;
    } on DioException catch (e, s) {
      log('Erro ao buscar fazendas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar fazendas');
    } catch (e, s) {
      log('Erro desconhecido ao buscar fazendas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar fazendas');
    }
  }
}
