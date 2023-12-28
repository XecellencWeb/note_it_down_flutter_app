import 'package:flutter/material.dart';
import 'package:task_manager_app/components/center_text.dart';
import '../../classes/index.dart';
import '../featured/one_task.dart';
import '../../functions/utils.dart';
import '../../graph_ql/queries.dart';

class ViewCreatedTask extends StatefulWidget {
  final String? userId;
  const ViewCreatedTask({super.key, required this.userId});

  @override
  State<ViewCreatedTask> createState() => _ViewCreatedTaskState();
}

class _ViewCreatedTaskState extends State<ViewCreatedTask> {
  final GraphQLQuery _graphQLQuery = GraphQLQuery();

  @override
  void initState() {
    super.initState();

    _loadTasks();
  }

  List tasksList = [];

  void _loadTasks() async {
    try {
      tasksList =
          await _graphQLQuery.getTasks(createdBy: widget.userId.toString());
      setState(() {});
    } catch (error) {
      print(error);
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: tasksList.isNotEmpty
          ? Column(
              children: tasksList
                  .map(
                    (todos) => OneTask(
                        hasOwner: true,
                        isEditMode: false,
                        task: todos,
                        taskInstance: todos.tasks,
                        openTaskViewer: () {
                          openAndCloseTask(todos);
                          setState(() {});
                        }),
                  )
                  .toList(),
            )
          : const CenterText(text: 'No Task Found'),
    );
  }
}
