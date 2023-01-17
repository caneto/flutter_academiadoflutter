import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';

import './tasks_services.dart';

class TasksServicesImpl implements TasksServices {
  final TasksRepository _tasksRepository;

  TasksServicesImpl({required TasksRepository taskRepository})
      : _tasksRepository = taskRepository;

  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepository.save(date, description);
}
