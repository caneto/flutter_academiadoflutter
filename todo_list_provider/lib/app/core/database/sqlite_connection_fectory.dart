import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list_provider/app/core/database/migration/migration.dart';
import 'package:todo_list_provider/app/core/database/sqlite_migration_fectory.dart';

class SqliteConnectionFectory {
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'TODO_LIST_PROVIDER';

  static SqliteConnectionFectory? _instance;

  Database? _db;
  final _lock = Lock();

  SqliteConnectionFectory._();

  factory SqliteConnectionFectory() {
    if (_instance == null) {
      _instance = SqliteConnectionFectory._();
    }
    return _instance!;
  }

  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    var databasePathFinal = join(databasePath, _DATABASE_NAME);
    if(_db == null) {
      _lock.synchronized(() async {
        if(_db == null) {
          _db = await openDatabase(
            databasePathFinal,
            version: _VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDowngrade
          );
        }
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();

    final migrations = SqliteMigrationFectory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }

    batch.commit();
  }
  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
     final batch = db.batch();

    final migrations = SqliteMigrationFectory().getUpgradeMigration(oldVersion);
    for (var migration in migrations) {
      migration.upgrade(batch);
    }

    batch.commit();
  }
  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
