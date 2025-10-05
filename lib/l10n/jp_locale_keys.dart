abstract class JPLocaleKeys {
  static const alreadyPaid = 'alreadyPaid';
  static const currency = 'currency';
  static const save = 'save';
  static const confirm = 'confirm';
  static const cancel = 'cancel';
  static const delete = 'delete';
  static const edit = 'edit';
  static const close = 'close';
  static const variableAmount = 'variableAmount';

  /// Languages
  static const String en = 'en';
  static const String pt = 'pt';

  /// Colors
  static const String green = 'green';
  static const String blue = 'blue';
  static const String red = 'red';
  static const String orange = 'orange';
  static const String purple = 'purple';
  static const String pink = 'pink';
  static const String teal = 'teal';
  static const String cyan = 'cyan';
  static const String lime = 'lime';
  static const String indigo = 'indigo';

  /// Months
  static const jan = 'jan';
  static const feb = 'feb';
  static const mar = 'mar';
  static const apr = 'apr';
  static const may = 'may';
  static const jun = 'jun';
  static const jul = 'jul';
  static const aug = 'aug';
  static const sep = 'sep';
  static const oct = 'oct';
  static const nov = 'nov';
  static const dec = 'dec';

  /// BillPaymentMethodEnum
  static const creditCard = 'creditCard';
  static const automaticDebit = 'automaticDebit';
  static const bankSlip = 'bankSlip';
  static const pix = 'pix';
  static const money = 'money';

  /// BillStatusEnum
  static const pending = 'pending';
  static const paid = 'paid';
  static const overdue = 'overdue';
  static const overdueToday = 'overdueToday';
  static const overdueTomorrow = 'overdueTomorrow';

  /// BaseModel
  static const dueDate = 'dueDate';
  static const dueDay = 'dueDay';
  static const onDay = 'onDay';
  static const onEveryDay = 'onEveryDay';
  static const paidOn = 'paidOn';

  /// BillPage
  static const editBill = 'editBill';
  static const createBill = 'createBill';
  static const cancelEditBill = 'cancelEditBill';
  static const cancelCreateBill = 'cancelCreateBill';
  static const cancelEditBillModalInfo = 'cancelEditBillModalInfo';
  static const cancelCreateBillModalInfo = 'cancelCreateBillModalInfo';
  static const cancelEditBillModalButtonLabel =
      'cancelEditBillModalButtonLabel';
  static const cancelCreateBillModalButtonLabel =
      'cancelCreateBillModalButtonLabel';
  static const billNameError = 'billNameError';
  static const billName = 'billName';
  static const billNameHint = 'billNameHint';
  static const billNameValidatorError = 'billNameValidatorError';
  static const billAmountError = 'billAmountError';
  static const billAmount = 'billAmount';
  static const billAmountValidatorError = 'billAmountValidatorError';
  static const billDueDateError = 'billDueDateError';
  static const billDueDate = 'billDueDate';
  static const billDueDateValidatorError = 'billDueDateValidatorError';
  static const billPaymentMethodError = 'billPaymentMethodError';
  static const billPaymentMethod = 'billPaymentMethod';
  static const billPaymentMethodHint = 'billPaymentMethodHint';
  static const billHasVariableAmount = 'billHasVariableAmount';
  static const billDeleteTitle = 'billDeleteTitle';
  static const billDeleteInfo = 'billDeleteInfo';
  static const billDeleteModalTitle = 'billDeleteModalTitle';
  static const billDeleteModalSnackBar = 'billDeleteModalSnackBar';
  static const billEditedSnackBar = 'billEditedSnackBar';
  static const billCreatedSnackBarError = 'billCreatedSnackBarError';
  static const billCreatedSnackBar = 'billCreatedSnackBar';
  static const billError = 'billError';

  /// BillPaymentDatePage
  static const dateTitle = 'dateTitle';

  /// BillVariableAmountPage
  static const variableAmountTitle = 'variableAmountTitle';
  static const variableAmountLabel = 'variableAmountLabel';
  static const variableAmountValidatorError = 'variableAmountValidatorError';

  /// HomePage
  static const homeAccount = 'homeAccount';
  static const homeAccountTab = 'homeAccountTab';
  static const homeHistoryTab = 'homeHistoryTab';
  static const homeBalanceTab = 'homeBalanceTab';
  static const homeSettingsTab = 'homeSettingsTab';

  /// BillConfirmationModalWidget
  static const billConfirmationModalTitle = 'billConfirmationModalTitle';
  static const billConfirmationModalPrimaryButtonLabel =
      'billConfirmationModalPrimaryButtonLabel';
  static const billConfirmationModalSecondaryButtonLabel =
      'billConfirmationModalSecondaryButtonLabel';
  static const billConfirmationModalSnack = 'billConfirmationModalSnack';
  static const billConfirmationModalDateTitle =
      'billConfirmationModalDateTitle';
  static const billConfirmationModalDateSubtitle =
      'billConfirmationModalDateSubtitle';

  /// BillsTabWidget
  static const billsNoData = 'billsNoData';
  static const billsCreateNew = 'billsCreateNew';

  /// HistoryTabWidget
  static const historyDeletePayment = 'historyDeletePayment';
  static const historyNoData = 'historyNoData';

  /// SettingsTabWidget
  static const settingsJoke = 'settingsJoke';
  static const settingsJokeReveal = 'settingsJokeReveal';
  static const settingsDarkMode = 'settingsDarkMode';
  static const settingsLanguage = 'settingsLanguage';
  static const settingsSelectLanguage = 'settingsSelectLanguage';
  static const settingsColors = 'settingsColors';
  static const settingsSelectColor = 'settingsSelectColor';
  static const settingsImportAllData = 'settingsImportAllData';
  static const settingsImportAllDataPermission =
      'settingsImportAllDataPermission';
  static const settingsImportAllDataAccessError =
      'settingsImportAllDataAccessError';
  static const settingsImportAllDataError = 'settingsImportAllDataError';
  static const settingsImportAllDataSuccess = 'settingsImportAllDataSuccess';
  static const settingsExportAllData = 'settingsExportAllData';
  static const settingsExportAllDataPermission =
      'settingsExportAllDataPermission';
  static const settingsDeleteAllData = 'settingsDeleteAllData';
  static const settingsDeleteAllDataModal = 'settingsDeleteAllDataModal';
  static const settingsDeleteAllDataSnack = 'settingsDeleteAllDataSnack';

  /// BalanceTabWidget
  static const balanceNoGraph = 'balanceNoGraph';

  /// Failures
  static const unknownFailure = 'unknownFailure';
  static const jokeAPIFailure = 'jokeAPIFailure';
  static const jokeRemoteFailure = 'jokeRemoteFailure';
}
