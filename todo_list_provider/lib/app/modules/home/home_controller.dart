import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_services.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksServices _tasksServices;
  var filterSelected = TaskFilterEnum.today;
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;
  bool showFinishingTasks = false;

  HomeController({required TasksServices tasksServices})
      : _tasksServices = tasksServices;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksServices.getToday(),
      _tasksServices.getTomorrow(),
      _tasksServices.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTasks = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );

    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    );

    weekTotalTasks = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length,
    );
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch(filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksServices.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksServices.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksServices.getWeek();
        initialDateOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    if(filter == TaskFilterEnum.week) {
      if(selectedDay != null) {
        filterByDay(selectedDay!);
      } else if(initialDateOfWeek != null) {
        filterByDay(initialDateOfWeek!);
      }
    } else {
      selectedDay = null;
    }

    if(!showFinishingTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
    }

    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks = allTasks.where((task) {
      return task.dateTime == date;
    }).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> checkOrUncheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();

    final taskUpdate = task.copyWith(
      finished: !task.finished
    );
    await _tasksServices.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

   void showOrHideFinishTask() {
    showFinishingTasks = !showFinishingTasks;
    refreshPage();
    notifyListeners();
  }

  Future<void> deleteTasks(int id) async {
    await _tasksServices.deleteById(id);
    refreshPage();
    notifyListeners();
  }

  Future<void> showOnlyFinishTask() async {
    filteredTasks = allTasks.where((task) {
      return task.finished;
    }).toList();
    notifyListeners();
  }

}
