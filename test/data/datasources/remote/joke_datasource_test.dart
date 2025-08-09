import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ja_paguei/data/datasources/datasources.dart';
import 'package:ja_paguei/data/errors/exceptions.dart';
import 'package:ja_paguei/data/models/models.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late MockDio mockDio;
  late JokeDatasource datasource;

  setUp(() {
    mockDio = MockDio();
    datasource = JokeDatasource(dio: mockDio);
  });

  const testLang = 'en';

  test('getJoke returns JokeModel on successful response', () async {
    final mockResponse = MockResponse();

    final data = {
      'setup': 'Why did the chicken cross the road?',
      'delivery': 'To get to the other side!',
      'type': 'twopart',
      'error': false,
    };

    when(() => mockResponse.data).thenReturn(data);

    when(
      () => mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
    ).thenAnswer((_) async => mockResponse);

    final result = await datasource.getJoke(languageCode: testLang);

    expect(result, isA<JokeModel>());
    expect(result.setup, data['setup']);
    expect(result.delivery, data['delivery']);
    expect(result.isTwoPart, true);

    verify(
      () => mockDio.get('/joke/Any', queryParameters: {'lang': testLang}),
    ).called(1);
  });

  test(
    'getJoke throws JokeAPIException when response has error=true',
    () async {
      final mockResponse = MockResponse();

      final data = {'error': true};

      when(() => mockResponse.data).thenReturn(data);

      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => mockResponse);

      expect(
        () => datasource.getJoke(languageCode: testLang),
        throwsA(isA<JokeAPIException>()),
      );
    },
  );

  test('getJoke throws RemoteException when Dio throws DioException', () async {
    when(
      () => mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
    ).thenThrow(DioException(requestOptions: RequestOptions(path: '/')));

    expect(
      () => datasource.getJoke(languageCode: testLang),
      throwsA(isA<RemoteException>()),
    );
  });
}
