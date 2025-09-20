import 'package:flutter/widgets.dart';

class BaseViewModel extends ChangeNotifier {
  bool hasDisposed = false;

  @override
  void dispose() {
    hasDisposed = true;
    super.dispose();
  }

  void safeNotify() {
    if (!hasDisposed) {
      notifyListeners();
    }
  }
}
