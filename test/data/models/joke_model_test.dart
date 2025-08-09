import 'package:flutter_test/flutter_test.dart';
import 'package:ja_paguei/data/models/models.dart';

void main() {
  group('JokeModel', () {
    test('fromJson parses two-part joke correctly', () {
      final json = {
        'setup': 'Why did the chicken cross the road?',
        'delivery': 'To get to the other side!',
        'type': 'twopart',
      };

      final joke = JokeModel.fromJson(json);

      expect(joke.setup, 'Why did the chicken cross the road?');
      expect(joke.delivery, 'To get to the other side!');
      expect(joke.isTwoPart, true);
      expect(joke.joke, isNull);
    });

    test('fromJson parses single-part joke correctly', () {
      final json = {
        'joke':
            'I told my wife she was drawing her eyebrows too high. She looked surprised.',
        'type': 'single',
      };

      final joke = JokeModel.fromJson(json);

      expect(joke.setup, isNull);
      expect(joke.delivery, isNull);
      expect(joke.isTwoPart, false);
      expect(joke.joke, isNotEmpty);
    });

    test('setupJoke returns setup when two-part', () {
      const joke = JokeModel(
        setup: 'Setup text',
        delivery: 'Delivery text',
        joke: 'Single joke',
        isTwoPart: true,
      );

      expect(joke.setupJoke, 'Setup text');
    });

    test('setupJoke returns joke when single-part', () {
      const joke = JokeModel(
        setup: null,
        delivery: null,
        joke: 'Single joke',
        isTwoPart: false,
      );

      expect(joke.setupJoke, 'Single joke');
    });

    test('setupJoke returns empty string if both setup and joke are null', () {
      const joke = JokeModel();

      expect(joke.setupJoke, '');
    });

    test('deliverJoke returns delivery when two-part', () {
      const joke = JokeModel(
        setup: 'Setup',
        delivery: 'Delivery',
        isTwoPart: true,
      );

      expect(joke.deliverJoke, 'Delivery');
    });

    test('deliverJoke returns empty string when single-part', () {
      const joke = JokeModel(joke: 'Single joke', isTwoPart: false);

      expect(joke.deliverJoke, '');
    });

    test('props includes all relevant fields', () {
      const joke1 = JokeModel(setup: 'A', delivery: 'B', joke: 'C');
      const joke2 = JokeModel(setup: 'A', delivery: 'B', joke: 'C');
      const joke3 = JokeModel(setup: 'X', delivery: 'Y', joke: 'Z');

      expect(joke1, joke2);
      expect(joke1 == joke3, isFalse);
    });
  });
}
