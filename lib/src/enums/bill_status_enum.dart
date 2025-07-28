import '../../ui.dart';

enum BillStatusEnum {
  pending(jpStatus: JPStatusEnum.warning),
  payed(jpStatus: JPStatusEnum.positive),
  overdue(jpStatus: JPStatusEnum.error);

  const BillStatusEnum({required this.jpStatus});

  final JPStatusEnum jpStatus;

  bool get isPayed => this == payed;

  bool get isNotPayed => this != payed;
}
