import 'package:flutter_modular/flutter_modular.dart';

abstract class ControllerLifeCycle implements Disposable {
  void onInit([Map<String, dynamic>? params]) {
    return;
  }

  void onReady() {
    return;
  }

  @override
  void dispose() {
    return;
  }
}
