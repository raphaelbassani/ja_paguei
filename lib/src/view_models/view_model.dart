import 'package:flutter/widgets.dart';

class ViewModel extends ChangeNotifier {
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
