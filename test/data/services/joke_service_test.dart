import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ja_paguei/core/extensions/extensions.dart';
import 'package:ja_paguei/data/datasources/datasources.dart';
import 'package:ja_paguei/data/errors/exceptions.dart';
import 'package:ja_paguei/data/errors/failures.dart';
import 'package:ja_paguei/data/models/models.dart';
import 'package:ja_paguei/data/services/services.dart';
import 'package:ja_paguei/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockJokeDatasource extends Mock implements JokeDatasource {}

void main() {
  late MockJokeDatasource mockDatasource;
  late JokeService jokeService;
  const testLanguageCode = 'en';

  setUp(() {
    mockDatasource = MockJokeDatasource();

    jokeService = JokeService(
      languageCode: testLanguageCode,
      datasource: mockDatasource,
    );
  });

  const testJokeModel = JokeModel(
    setup: 'Setup',
    delivery: 'Delivery',
    joke: null,
    isTwoPart: true,
  );

  test('getJoke returns Right with JokeModel on success', () async {
    when(
      () => mockDatasource.getJoke(languageCode: testLanguageCode),
    ).thenAnswer((_) async => testJokeModel);

    final response = await jokeService.getJoke();

    late final JokeModel result;
    response.fold(
      ifLeft: (_) => null,
      ifRight: (success) {
        result = success;
      },
    );

    expect(response.isRight, true);
    expect(result, testJokeModel);
  });

  testWidgets(
    'getJoke returns Left with GetJokeAPIFailure when JokeAPIException thrown',
    (tester) async {
      late BuildContext ctx;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              ctx = context;
              return const Placeholder();
            },
          ),
        ),
      );

      when(
        () => mockDatasource.getJoke(languageCode: testLanguageCode),
      ).thenThrow(JokeAPIException());

      final response = await jokeService.getJoke();

      late final Failure result;
      response.fold(
        ifLeft: (failure) {
          result = failure;
        },
        ifRight: (_) => null,
      );

      expect(response.isLeft, true);
      expect(result, isA<GetJokeAPIFailure>());
      expect(result.message, ctx.translate(JPLocaleKeys.jokeAPIFailure));
    },
  );

  testWidgets(
    'getJoke returns Left with GetJokeFailure when RemoteException thrown',
    (tester) async {
      late BuildContext ctx;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              ctx = context;
              return const Placeholder();
            },
          ),
        ),
      );

      when(
        () => mockDatasource.getJoke(languageCode: testLanguageCode),
      ).thenThrow(RemoteException());

      final response = await jokeService.getJoke();

      late final Failure result;
      response.fold(
        ifLeft: (failure) {
          result = failure;
        },
        ifRight: (_) => null,
      );

      expect(response.isLeft, true);
      expect(result.message, ctx.translate(JPLocaleKeys.jokeRemoteFailure));
    },
  );

  testWidgets('getJoke returns Left with UnknownFailure on other exceptions', (
    tester,
  ) async {
    late BuildContext ctx;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            ctx = context;
            return const Placeholder();
          },
        ),
      ),
    );

    when(
      () => mockDatasource.getJoke(languageCode: testLanguageCode),
    ).thenThrow(Exception());

    final response = await jokeService.getJoke();

    late final Failure result;
    response.fold(
      ifLeft: (failure) {
        result = failure;
      },
      ifRight: (_) => null,
    );

    expect(response.isLeft, true);
    expect(result.message, ctx.translate(JPLocaleKeys.unknownFailure));
  });
}
