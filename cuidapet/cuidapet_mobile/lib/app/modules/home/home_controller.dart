import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {

  @override
  void onInit([Map<String, dynamic>? params]) {
    print('On Init chamado');
  }

  @override
  void onReady() {
    print('OnReady chamado');
  }

}
