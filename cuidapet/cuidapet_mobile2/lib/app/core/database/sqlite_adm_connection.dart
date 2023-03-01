import 'package:flutter/material.dart';

import 'sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    final connection = SqliteConnectionFactory();
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await connection.closeConnection();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
