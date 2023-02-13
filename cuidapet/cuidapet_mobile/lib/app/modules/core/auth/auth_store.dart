import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/local_storage/local_storage.dart';
import '../../../models/user_model.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  
 final LocalStorage _localStorage;
 final LocalSecureStorage _localSecureStorage;

 AuthStoreBase({
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
  })  : _localStorage = localStorage,
        _localSecureStorage = localSecureStorage;

  @readonly
  UserModel? _loggedUser;

  @action
  Future<void> loadLoggedUser() async {
    final user = await _localStorage
        .read<String>(Constants.localStorageLoggedUserDataKey);

    _loggedUser =
        user != null ? UserModel.fromJson(user) : const UserModel.empty();

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
          await logout();
      }
    });
  }

  @action
  Future<void> logout() async {
    await _localStorage.clear();
    await _localSecureStorage.clear();
    //await _addressService.deleteAll();
    _loggedUser = const UserModel.empty();
  }
}
