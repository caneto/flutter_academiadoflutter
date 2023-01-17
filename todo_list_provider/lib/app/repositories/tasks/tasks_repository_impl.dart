import 'package:todo_list_provider/app/core/database/sqlite_connection_fectory.dart';

import './tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFectory _sqliteConnectionFectory;

  TasksRepositoryImpl(
      {required SqliteConnectionFectory sqliteConnectionFectory})
      : _sqliteConnectionFectory = sqliteConnectionFectory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFectory.openConnection();
    await conn.insert("todo", {
      'id':null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0
    });
  }
}
