// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, prefer_final_fields
import 'package:mobx/mobx.dart';

import '../model/full_name.dart';

class ContadorController {
  var _counter = Observable<int>(0, name: "conuter observable");
  var _fullName = Observable<FullName>(FullName(first: "first", last: "last"));
  late Action increment;
  late Computed _saudacaoComputed;

  ContadorController() {
    increment = Action(_incrementCounter);
    _saudacaoComputed = Computed(() => "Olá ${_fullName.value.first}");
  }
  int get counter => _counter.value;

  FullName get fullname => _fullName.value;

  String get saudacao => _saudacaoComputed.value;

  void _incrementCounter() {
    print("Antes ");
    print(_fullName.value.hashCode);
    _counter.value++;
    //! Não posso instanciar como =
    // _fullName.value.first = "Carlos";
    // _fullName.value.last = "Alberto";
    _fullName.value = FullName(first: "Carlos", last: "Alberto");
    print("Depois");
    print(_fullName.value.hashCode);
  }
}
