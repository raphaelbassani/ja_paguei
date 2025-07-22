import '../../ui.dart';

enum BillStatusEnum {
  pending(label: 'Pendente', status: JPStatusEnum.warning),
  payed(label: 'Pago', status: JPStatusEnum.positive),
  overdue(label: 'Atrasado', status: JPStatusEnum.error);

  const BillStatusEnum({required this.label, required this.status});

  final String label;
  final JPStatusEnum status;
}
