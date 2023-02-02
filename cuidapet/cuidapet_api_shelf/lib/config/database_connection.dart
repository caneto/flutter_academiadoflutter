import 'dart:async';

import 'package:cuidapet_api/config/database_params_config.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseConnection {
  static Future<MySqlConnection> openConnection() async {
    return await MySqlConnection.connect(
      ConnectionSettings(
        host: DatabaseParamsConfig.host,
        port: DatabaseParamsConfig.port,
        user: DatabaseParamsConfig.user,
        password: DatabaseParamsConfig.password,
        db: DatabaseParamsConfig.databaseName,
      ),
    );
  }
}
