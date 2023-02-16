import 'migrations/migration.dart';
import 'migrations/migration_v1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigrations() => [MigrationV1()];

  List<Migration> getUpgradeMigrations(int _) => const [];
}
