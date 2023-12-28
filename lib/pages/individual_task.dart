import 'package:flutter/material.dart';
import 'package:task_manager_app/classes/index.dart';
import 'package:task_manager_app/components/featured/one_task.dart';

import 'package:task_manager_app/functions/utils.dart';
import 'package:task_manager_app/graph_ql/queries.dart';

class IndividualTasks extends StatefulWidget {
  final User individual;
  const IndividualTasks({
    super.key,
    required this.individual,
  });

  @override
  State<IndividualTasks> createState() => _IndividualTasksState();
}

class _IndividualTasksState extends State<IndividualTasks> {
  @override
  void initState() {
    super.initState();

    _loadIndividualTask();
  }

  final GraphQLQuery _graphQLQuery = GraphQLQuery();
  List tasksList = [];

  void _loadIndividualTask() async {
    try {
      tasksList = await _graphQLQuery.getTasks(
          createdBy: widget.individual.id.toString());

      setState(() {});
    } catch (error) {
      print(error);
      throw Exception(error);
    }
  }

  void openTodo(todo, value) {
    setState(() {
      todo.opened = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 231, 193, 238),
          title: Text('${widget.individual.name} Tasks'),
          leading: BackButton(onPressed: () {
            Navigator.pop(context);
          }),
        ),
        body: Column(
            children: tasksList
                .map(
                  (task) => OneTask(
                      isEditMode: false,
                      task: task,
                      taskInstance: task.tasks,
                      openTaskViewer: () {
                        openAndCloseTask(task);
                        setState(() {});
                      }),
                )
                .toList()),
      ),
    );
  }
}
