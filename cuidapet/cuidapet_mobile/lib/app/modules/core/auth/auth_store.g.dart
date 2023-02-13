// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$_loggedUserAtom =
      Atom(name: 'AuthStoreBase._loggedUser', context: context);

  UserModel? get loggedUser {
    _$_loggedUserAtom.reportRead();
    return super._loggedUser;
  }

  @override
  UserModel? get _loggedUser => loggedUser;

  @override
  set _loggedUser(UserModel? value) {
    _$_loggedUserAtom.reportWrite(value, super._loggedUser, () {
      super._loggedUser = value;
    });
  }

  late final _$loadLoggedUserAsyncAction =
      AsyncAction('AuthStoreBase.loadLoggedUser', context: context);

  @override
  Future<void> loadLoggedUser() {
    return _$loadLoggedUserAsyncAction.run(() => super.loadLoggedUser());
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthStoreBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
