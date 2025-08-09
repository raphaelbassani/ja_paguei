import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ja_paguei/data/datasources/datasources.dart';
import 'package:ja_paguei/data/models/history_model.dart';
import 'package:ja_paguei/presentation/enums/enums.dart';

void main() {
  final tHistory = HistoryModel(
    id: 1,
    billId: 42,
    name: 'Electricity Bill',
    amount: 123.45,
    paymentMethod: BillPaymentMethodEnum.automaticDebit,
    dueDay: 15,
    isVariableAmount: false,
    paymentDateTime: DateTime(2023, 7, 10),
  );

  group('HistoryModel - Serialization', () {
    test('fromJson creates object correctly', () {
      final json = {
        HistoryFields.id: 1,
        HistoryFields.billId: '42',
        HistoryFields.name: 'Electricity Bill',
        HistoryFields.amount: '123.45',
        HistoryFields.paymentMethod: 'automaticDebit',
        HistoryFields.dueDay: '15',
        HistoryFields.isVariableAmount: '0',
        HistoryFields.paymentDateTime: '2023-07-10T00:00:00',
      };

      final model = HistoryModel.fromJson(json);

      expect(model.id, 1);
      expect(model.billId, 42);
      expect(model.name, 'Electricity Bill');
      expect(model.amount, 123.45);
      expect(model.paymentMethod, BillPaymentMethodEnum.automaticDebit);
      expect(model.dueDay, 15);
      expect(model.isVariableAmount, false);
      expect(model.paymentDateTime, DateTime.parse('2023-07-10T00:00:00'));
    });

    test('toJson returns correct map', () {
      final json = tHistory.toJson();

      expect(json[HistoryFields.id], 1);
      expect(json[HistoryFields.billId], 42);
      expect(json[HistoryFields.name], 'Electricity Bill');
      expect(json[HistoryFields.amount], '123.45');
      expect(json[HistoryFields.paymentMethod], 'automaticDebit');
      expect(json[HistoryFields.dueDay], '15');
      expect(json[HistoryFields.isVariableAmount], '0');
      expect(json[HistoryFields.paymentDateTime], '2023-07-10T00:00:00.000');
    });
  });

  group('HistoryModel - Copy methods', () {
    test('copyWithId changes only the id', () {
      final copy = tHistory.copyWithId(id: 2);

      expect(copy.id, 2);
      expect(copy.billId, tHistory.billId);
      expect(copy.name, tHistory.name);
      expect(copy.amount, tHistory.amount);
      expect(copy.paymentMethod, tHistory.paymentMethod);
      expect(copy.dueDay, tHistory.dueDay);
      expect(copy.isVariableAmount, tHistory.isVariableAmount);
      expect(copy.paymentDateTime, tHistory.paymentDateTime);
    });
  });

  group('HistoryModel - Getters and Methods using WidgetTester', () {
    testWidgets('formattedAmount returns correctly formatted string', (
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

      final formatted = tHistory.formattedAmount(ctx);
      expect(formatted, contains('123.45'));
    });

    testWidgets('labelWithDueDate returns expected string', (tester) async {
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

      final label = tHistory.labelWithDueDate(ctx);

      // Since paymentMethod is automaticDebit, label should contain automaticDebit key string
      expect(label, contains('Automatic debit'));
      expect(label, contains('15th'));
    });

    testWidgets(
      'labelWithPaymentDate returns expected string when paymentDateTime is not null',
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

        final label = tHistory.labelWithPaymentDate(ctx);

        expect(label, contains('Paid on'));
        expect(label, contains('07/10/2023'));
      },
    );

    testWidgets(
      'labelWithPaymentDate returns empty string when paymentDateTime is null',
      (tester) async {
        const historyWithoutDate = HistoryModel(
          id: 1,
          billId: 42,
          name: 'Electricity Bill',
          amount: 123.45,
          paymentMethod: BillPaymentMethodEnum.automaticDebit,
          dueDay: 15,
          isVariableAmount: false,
          paymentDateTime: null,
        );

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

        final label = historyWithoutDate.labelWithPaymentDate(ctx);
        expect(label, '');
      },
    );

    test('formattedDueDay pads single digit dueDay with zero', () {
      final singleDigitDueDayHistory = HistoryModel(
        id: 1,
        billId: 42,
        name: 'Electricity Bill',
        amount: 123.45,
        paymentMethod: BillPaymentMethodEnum.automaticDebit,
        dueDay: 5,
        isVariableAmount: false,
        paymentDateTime: DateTime(2023, 7, 10),
      );
      expect(singleDigitDueDayHistory.formattedDueDay, '05');
    });

    test('isPaymentMethodAutomatic returns true when method is automatic', () {
      expect(tHistory.isPaymentMethodAutomatic, isTrue);
    });

    test(
      'isNotPaymentMethodAutomatic returns true when method is not automatic',
      () {
        final nonAutoHistory = HistoryModel(
          id: 1,
          billId: 42,
          name: 'Electricity Bill',
          amount: 123.45,
          paymentMethod: BillPaymentMethodEnum.pix,
          dueDay: 5,
          isVariableAmount: false,
          paymentDateTime: DateTime(2023, 7, 10),
        );
        expect(nonAutoHistory.isNotPaymentMethodAutomatic, isTrue);
      },
    );
  });
}
