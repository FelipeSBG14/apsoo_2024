import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class CustomDio extends DioForNative {
  CustomDio()
      : super(
          BaseOptions(
            baseUrl: 'http://localhost:8080',
            connectTimeout: const Duration(
              seconds: 5,
            ),
            receiveTimeout: const Duration(
              seconds: 60,
            ),
          ),
        );
}
