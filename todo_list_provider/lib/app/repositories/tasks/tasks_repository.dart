import 'package:todo_list_provider/app/models/task_model.dart';

abstract class TasksRepository {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findByperiod(DateTime start, DateTime end);
}