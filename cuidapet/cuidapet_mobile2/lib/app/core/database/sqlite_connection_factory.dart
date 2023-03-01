import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

import 'sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  factory SqliteConnectionFactory() =>
      _instance ??= SqliteConnectionFactory._();

  SqliteConnectionFactory._();

  static const _version = 1;

  static const _databaseName = 'cuidapet_local_db';
  static SqliteConnectionFactory? _instance;

  Database? _database;

  final _lock = Lock();

  Future<Database> openConnection() async {
    if (_database == null) {
      await _lock.synchronized(() async {
        final databasePath = await getDatabasesPath();
        final path = join(databasePath, _databaseName);

        _database = await openDatabase(
          path,
          version: _version,
          onCreate: _onCreate,
          onConfigure: _onConfigure,
          onUpgrade: _onUpgrade,
        );
      });
    }

    return _database!;
  }

  Future<FutureOr<void>> _onUpgrade(
    Database db,
    int oldVersion,
    int _,
  ) async {
    final batch = db.batch();

    final migrations =
        SqliteMigrationFactory().getUpgradeMigrations(oldVersion);

    for (final migration in migrations) {
      migration.upgrade(batch);
    }

    await batch.commit();
  }

  FutureOr<void> _onCreate(Database db, int _) async {
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getCreateMigrations();

    for (final migration in migrations) {
      migration.create(batch);
    }

    await batch.commit();
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> closeConnection() async {
    await _database?.close();
    _database = null;
  }
}
