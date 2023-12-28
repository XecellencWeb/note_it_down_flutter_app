import 'package:flutter/material.dart';
import 'package:task_manager_app/components/create_component/create_button.dart';
import 'package:task_manager_app/constants/names.dart';
import 'package:task_manager_app/functions/utils.dart';
import './form.dart';
import '../featured/one_task.dart';
import '../../classes/index.dart';
import '../../graph_ql/mutation.dart';

class CreateComponent extends StatefulWidget {
  final bool isEditing;
  final String userid;
  const CreateComponent({
    super.key,
    required this.userid,
    this.isEditing = false,
  });

  @override
  State<CreateComponent> createState() => _CreateComponentState();
}

class _CreateComponentState extends State<CreateComponent> {
  Task newTask = Task();
  TaskInstance newTaskInstance = TaskInstance();
  final GraphQLMutation _graphQLMutation = GraphQLMutation();
  final TextEditingController _heading = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  void _createNewTask() async {
    try {
      await _graphQLMutation.createTasks(
        task: Task.toMap(task: newTask),
        userId: widget.userid,
      );
      print('Task created');
    } catch (error) {
      print(error);
      throw Exception(error);
    }
  }

  void _editTask() async {}

  void _submitForm() async {
    newTask.name = _heading.text;
    newTask.description = _desc.text;
    newTask.taskCreated = true;

    setState(() {});
  }

  void _taskSubmitHandler({
    required TaskInstance instance,
    required bool writingMode,
    required bool isAbove,
    required int index,
    required bool isRemoving,
  }) {
    if (isRemoving) {
      newTask.tasks = [
        ...newTask.tasks.sublist(0, index),
        ...newTask.tasks.sublist(index + 1)
      ];
      return;
    }
    if (writingMode && !isAbove) {
      //if we are adding from the end
      if (newTask.tasks.isEmpty || index == newTask.tasks.length) {
        newTask.tasks = [...newTask.tasks, instance];
        return;
      }
      newTask.tasks = [
        ...newTask.tasks.sublist(0, index + 1),
        instance,
        ...newTask.tasks.sublist(index + 1)
      ];
      return;
    }
    if (isAbove && writingMode) {
      newTask.tasks = [
        ...newTask.tasks.sublist(0, index),
        instance,
        ...newTask.tasks.sublist(index)
      ];
      return;
    }

    newTask.tasks[index] = instance;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: newTask.taskCreated == false
          ? SingleChildScrollView(
              child: Column(
                children: [
                  CreateForm(
                    headingInput: _heading,
                    descriptionInput: _desc,
                  ),
                  ButtonGroup(buttonText: "Create", submitFunction: _submitForm)
                ],
              ),
            )
          : SingleChildScrollView(
            child: Column(
                children: [
                  OneTask(
                    task: newTask,
                    taskInstance: newTask.tasks,
                    openTaskViewer: () {
                      openAndCloseTask(newTask);
                      setState(() {});
                    },
                    submitFunc: (instance, mode, index, position, removing) {
                      _taskSubmitHandler(
                        instance: instance,
                        writingMode: mode,
                        isAbove: position,
                        index: index,
                        isRemoving: removing,
                      );
                      setState(() {});
                    },
                  ),
                  Container(
                    margin:const EdgeInsets.symmetric(vertical: 20),
                    width: 150,
                    child: FloatingActionButton(
                      onPressed: widget.isEditing ? _editTask : _createNewTask,
                      child: Text(widget.isEditing ? 'Edit Task' : 'Create Task'),
                    ),
                  )
                ],
              ),
          ),
    );
  }
}
