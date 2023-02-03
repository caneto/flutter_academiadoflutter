import 'package:cuidapet/app/models/user_model.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  
  @readonly
  UserModel? _userLogged;

  @action
  Future<void> loadUSerLogged() async {
    _userLogged = UserModel.empty();
  }

}

