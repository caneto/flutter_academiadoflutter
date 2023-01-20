import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_model.dart';

import '../home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');

  Task({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        dragDismissible: true,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(100),
                topLeft: Radius.circular(100)),
            label: "Excluir",
            foregroundColor: Colors.white,
            onPressed: (_) =>
                context.read<HomeController>().deleteTasks(model.id),
            icon: Icons.delete,
            backgroundColor: context.deleteColor,
          )
        ],
      ),
      child: Card(
        shadowColor: context.primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.primaryColorLight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: IntrinsicHeight(
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: Checkbox(
              value: model.finished,
              onChanged: (value) =>
                  context.read<HomeController>().checkOrUncheckTask(model),
            ),
            title: Text(
              model.description,
              style: TextStyle(
                // ignore: dead_code
                decoration: model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              dateFormat.format(model.dateTime),
              style: TextStyle(
                // ignore: dead_code
                decoration: model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(width: 1)),
          ),
        ),
      ),
    );
  }
}
