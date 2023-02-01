// ignore_for_file: library_private_types_in_public_api

import 'package:imc_mobx/example/model/full_name.dart';
import 'package:mobx/mobx.dart';

part 'contador_codegen_controller.g.dart';

class ContadorCodegenController = _ContadorCodegenControllerBase
    with _$ContadorCodegenController;

abstract class _ContadorCodegenControllerBase with Store {
  @observable
  int counter = 0;

  @observable
  var fullName = FullName(first: "first", last: "last");

  String get saudacao => "Olá ${fullName.first}";

  @action
  void increment() {
    counter++;
    fullName = FullName(first: "Carlos", last: "Alberto");
  }

  @action
  void changeName() {
    fullName = FullName(first: "Cristiane", last: "Cunha");
  }

  @action
  void rollBackName() {
    fullName = FullName(first: "first", last: "last");
  }
}
