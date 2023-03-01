import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute(
      '''
      CREATE TABLE address (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        address TEXT NOT NULL,
        lat TEXT,
        lng TEXT,
        additionalInfo TEXT
      )
''',
    );
  }

  @override
  void upgrade(Batch batch) {
    return;
  }
}
