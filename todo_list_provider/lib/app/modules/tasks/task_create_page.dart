import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';

class TaskCreatePage extends StatelessWidget {
  
  TaskCreateController _controller;

  TaskCreatePage({Key? key, required TaskCreateController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
      ),
      body: Container(),
    );
  }
}
