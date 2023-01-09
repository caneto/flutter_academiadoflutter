

import 'package:flutter/material.dart';

class ProviderController extends ChangeNotifier {
  String name = 'Nome';
  String imgAvatar = 'https://avatars.githubusercontent.com/u/2157300?v=4';
  String birthDate = 'Data';

  void alterarDados() {
    name = 'Carlos Alberto';
    imgAvatar = 'https://avatars.githubusercontent.com/u/2157300?v=4';
    birthDate = '29/04/1966';
    notifyListeners();
  }

  void alterarNome() {
    name = 'Curso de Flutter';
    notifyListeners();
  }
}