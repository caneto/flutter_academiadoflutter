import 'package:todo_list_provider/app/core/database/sqlite_connection_fectory.dart';
import 'package:todo_list_provider/app/models/task_model.dart';

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
      'id': null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0
    });
  }

  @override
  Future<List<TaskModel>> findByperiod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _sqliteConnectionFectory.openConnection();
    final result = await conn.rawQuery(
        '''
      select *
      from todo
      where data_hora between ? and ?
      order by data_hora
    ''',
        [
          startFilter.toIso8601String(),
          endFilter.toIso8601String(),
        ]);
    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }
}
