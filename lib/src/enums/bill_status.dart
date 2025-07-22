import '../../ui.dart';

enum BillStatusEnum {
  pending(label: 'Pendente', jpStatus: JPStatusEnum.warning),
  payed(label: 'Pago', jpStatus: JPStatusEnum.positive),
  overdue(label: 'Atrasado', jpStatus: JPStatusEnum.error);

  const BillStatusEnum({required this.label, required this.jpStatus});

  final String label;
  final JPStatusEnum jpStatus;

  bool get isPayed => this == payed;
}
