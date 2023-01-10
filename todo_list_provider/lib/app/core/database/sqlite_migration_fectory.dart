
import 'package:todo_list_provider/app/core/database/migration/migration.dart';
import 'package:todo_list_provider/app/core/database/migration/migration_v1.dart';

class SqliteMigrationFectory {
  
  // Tera todas as migrations
  List<Migration> getCreateMigration() => [
    MigrationV1(),
    //v2
    //v3
  ];

  List<Migration> getUpgradeMigration(int version) {
    final migrations = <Migration>[];

    // tera a 2 e 3
    if(version == 1) {
      // v2
      // v3  
    }

    // tera somente a 3
    if(version == 2) {
      // v3
    }

    return migrations;
  }

}