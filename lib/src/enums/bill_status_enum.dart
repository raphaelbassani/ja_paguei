import '../../ui.dart';

enum BillStatusEnum {
  pending(jpStatus: JPStatusEnum.warning),
  paid(jpStatus: JPStatusEnum.positive),
  overdue(jpStatus: JPStatusEnum.error);

  const BillStatusEnum({required this.jpStatus});

  final JPStatusEnum jpStatus;

  bool get isPaid => this == paid;

  bool get isNotPaid => this != paid;
}
