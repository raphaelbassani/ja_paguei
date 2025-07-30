import 'package:dio/dio.dart';

import '../../errors/exceptions.dart';
import '../../models/models.dart';

class JokeDatasource {
  final Dio _dio;

  JokeDatasource({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://v2.jokeapi.dev/'));

  Future<JokeModel> getJoke({required String languageCode}) async {
    try {
      final queryParams = <String, dynamic>{'lang': languageCode};

      final response = await _dio.get(
        '/joke/Any',
        queryParameters: queryParams,
      );

      if (response.data['error'] == true) {
        throw JokeAPIException();
      }

      return JokeModel.fromJson(response.data);
    } on DioException catch (_) {
      throw RemoteException();
    }
  }
}
