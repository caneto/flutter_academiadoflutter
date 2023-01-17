import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_services.dart';

class TaskCreateController extends DefaultChangeNotifier {
  TasksServices _tasksServices;
  DateTime? _selectedDate;

  TaskCreateController({required TasksServices tasksServices})
      : _tasksServices = tasksServices;

  set selectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }
      
  DateTime? get selectedDate => _selectedDate;   
}
