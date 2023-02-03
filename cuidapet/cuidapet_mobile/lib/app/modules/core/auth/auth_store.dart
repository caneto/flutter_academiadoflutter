import 'package:mobx/mobx.dart';

import '../../../models/user_model.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  
  @readonly
  UserModel? _loggedUser;

  @action
  Future<void> loadLoggedUser() async {
    _loggedUser = const UserModel.empty();
  }

}
