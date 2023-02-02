import 'package:cuidapet_api/cuidapet_api.dart';
import 'package:yaml/yaml.dart';

class DatabaseParamsConfig {
  static String host;
  static int port;
  static String user;
  static String password;
  static String databaseName;

  static void load(String file) {
    final String contents = File(file).readAsStringSync();
    final config = loadYaml(contents) as Map<dynamic, dynamic>;

    final Map<dynamic, dynamic> database = config['database'] as Map<dynamic, dynamic>;

    host = database['host'] as String;
    port = database['port'] as int;
    user = database['user'] as String;
    password = database['password'] as String;
    databaseName = database['database'] as String;
  }
}
