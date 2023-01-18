// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'task_model.dart';

class WeekTaskModel {
  final DateTime startDate;
  final DateTime endDate;
  final List<TaskModel> tasks;
  const WeekTaskModel({
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });
}
