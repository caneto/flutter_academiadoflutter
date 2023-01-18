// ignore_for_file: prefer_final_fields, avoid_print

import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_services.dart';

class TaskCreateController extends DefaultChangeNotifier {
  TasksServices _tasksServices;
  DateTime? _selectedDate;

  TaskCreateController({required TasksServices tasksServices})
      : _tasksServices = tasksServices;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _tasksServices.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da task não selecionada');
      }
    }  catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
