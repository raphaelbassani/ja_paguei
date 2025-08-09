import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ja_paguei/data/datasources/datasources.dart';
import 'package:ja_paguei/data/models/models.dart';
import 'package:ja_paguei/presentation/enums/enums.dart';

void main() {
  final tBill = BillModel(
    id: 1,
    name: 'Electric Bill',
    amount: 120.50,
    paymentMethod: BillPaymentMethodEnum.pix,
    dueDay: 15,
    isVariableAmount: false,
    status: BillStatusEnum.pending,
    paymentDateTime: DateTime(2025, 8, 8),
    createdAt: DateTime(2025, 8, 1),
  );

  group('BillModel - Getters', () {
    test('isPaid should return true when status is paid', () {
      final bill = tBill.copyWith(status: BillStatusEnum.paid);
      expect(bill.isPaid, isTrue);
    });

    test('isNotPaid should return true when status is not paid', () {
      expect(tBill.isNotPaid, isTrue);
    });

    test('formattedDueDay should pad day with zero when less than 10', () {
      expect(tBill.copyWith(dueDay: 5).formattedDueDay, '05');
    });
  });

  group('BillModel - Serialization', () {
    test('toJson should return correct map', () {
      final json = tBill.toJson();

      expect(json[BillFields.id], 1);
      expect(json[BillFields.name], 'Electric Bill');
      expect(json[BillFields.amount], '120.50');
      expect(json[BillFields.paymentMethod], 'pix');
      expect(json[BillFields.dueDay], '15');
      expect(json[BillFields.status], 'pending');
      expect(json[BillFields.isVariableAmount], '0');
    });

    test('fromJson should create correct object', () {
      final json = {
        BillFields.id: 2,
        BillFields.name: 'Water Bill',
        BillFields.amount: '200.75',
        BillFields.paymentMethod: 'pix',
        BillFields.dueDay: '10',
        BillFields.status: 'paid',
        BillFields.isVariableAmount: '1',
        BillFields.paymentDateTime: '2025-08-08T00:00:00.000',
        BillFields.createdAt: '2025-08-01T00:00:00.000',
      };

      final bill = BillModel.fromJson(json);

      expect(bill.id, 2);
      expect(bill.name, 'Water Bill');
      expect(bill.amount, 200.75);
      expect(bill.status, BillStatusEnum.paid);
      expect(bill.isVariableAmount, true);
    });
  });

  group('BillModel - Copy Methods', () {
    test('copyWith should change only provided fields', () {
      final newBill = tBill.copyWith(amount: 500.0);

      expect(newBill.amount, 500.0);
      expect(newBill.name, 'Electric Bill');
    });

    test('copyWithNullId should set id to null', () {
      final newBill = tBill.copyWithNullId();

      expect(newBill.id, isNull);
      expect(newBill.name, 'Electric Bill');
    });

    test('copyWithCleaningPayment should reset status and payment date', () {
      final newBill = tBill.copyWithCleaningPayment();

      expect(newBill.status, BillStatusEnum.pending);
      expect(newBill.paymentDateTime, isNull);
    });

    test('toHistoryModel should return HistoryModel', () {
      final HistoryModel historyModel = HistoryModel(
        id: null,
        billId: 1,
        name: 'Electric Bill',
        amount: 120.5,
        paymentMethod: BillPaymentMethodEnum.pix,
        dueDay: 15,
        paymentDateTime: DateTime(2025, 8, 8),
        isVariableAmount: false,
      );
      final newHistoryModel = tBill.toHistoryModel;

      expect(historyModel, newHistoryModel);
    });
  });

  group('Methods using WidgetTester', () {
    testWidgets('formattedAmount returns correct value', (tester) async {
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

      final result = tBill.formattedAmount(ctx);
      expect(result, contains('120.50'));
    });

    testWidgets('labelWithDueDate returns correct string', (tester) async {
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

      final result = tBill.labelWithDueDate(ctx);
      expect(result, contains('Due date'));
      expect(result, contains('15'));
    });

    testWidgets('labelWithPaymentDate returns correct string', (tester) async {
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

      final result = tBill.labelWithPaymentDate(ctx);
      expect(result, contains('Paid on'));
      expect(result, contains('08/08/2025'));
    });

    testWidgets('labelWithPaymentDate returns empty when null', (tester) async {
      final billWithoutDate = BillModel(
        id: 1,
        name: 'Electric Bill',
        amount: 120.50,
        paymentMethod: BillPaymentMethodEnum.pix,
        dueDay: 15,
        isVariableAmount: false,
        status: BillStatusEnum.pending,
        createdAt: DateTime(2025, 8, 1),
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

      final result = billWithoutDate.labelWithPaymentDate(ctx);
      expect(result, '');
    });
  });
}
