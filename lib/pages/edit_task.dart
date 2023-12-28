import 'package:flutter/material.dart';
import 'package:task_manager_app/classes/index.dart';
import 'package:task_manager_app/components/create_component/form.dart';
import 'package:task_manager_app/components/featured/one_task.dart';
import 'package:task_manager_app/constants/names.dart';
import 'package:task_manager_app/functions/utils.dart';
import 'package:task_manager_app/graph_ql/mutation.dart';

class EditTask extends StatefulWidget {
  final Task editableTask;

  const EditTask({
    super.key,
    required this.editableTask,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TaskInstance newTaskInstance = TaskInstance();
  final GraphQLMutation _graphQLMutation = GraphQLMutation();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  void initFormFunc() {
    _name.text = widget.editableTask.name.toString();
    _desc.text = widget.editableTask.description.toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    initFormFunc();
  }

  @override
  Widget build(BuildContext context) {
    Task editTask = widget.editableTask;

    void updateFunc() async {
      try {
        await _graphQLMutation.updateTask(task: Task.toMap(task: editTask), taskId: editTask.id);
        print('Update Sucessful');
      } catch (error) {
        print(error);
        throw Exception(error);
      }
    }

    void taskSubmitHandler({
      required TaskInstance instance,
      required bool writingMode,
      required bool isAbove,
      required int index,
      required bool isRemoving,
    }) {
      if (isRemoving) {
        editTask.tasks = [
          ...editTask.tasks.sublist(0, index),
          ...editTask.tasks.sublist(index + 1)
        ];
        return;
      }
      if (writingMode && !isAbove) {
        //if we are adding from the end
        if (editTask.tasks.isEmpty || index == editTask.tasks.length) {
          editTask.tasks = [...editTask.tasks, instance];
          return;
        }
        editTask.tasks = [
          ...editTask.tasks.sublist(0, index + 1),
          instance,
          ...editTask.tasks.sublist(index + 1)
        ];
        return;
      }
      if (isAbove && writingMode) {
        editTask.tasks = [
          ...editTask.tasks.sublist(0, index),
          instance,
          ...editTask.tasks.sublist(index)
        ];
        return;
      }

      editTask.tasks[index] = instance;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(editTask.name.toString()),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            children: [
              CreateForm(
                headingInput: _name,
                descriptionInput: _desc,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: 150,
                child: FloatingActionButton(
                  onPressed: () {
                    editTask.name = _name.text;
                    editTask.description = _desc.text;

                    setState(() {});
                  },
                  child: const Text('Update Task Header'),
                ),
              ),
              OneTask(
                task: editTask,
                taskInstance: editTask.tasks,
                openTaskViewer: () {
                  openAndCloseTask(editTask);
                  setState(() {});
                },
                submitFunc: (instance, mode, index, position, removing) {
                  taskSubmitHandler(
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
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: 150,
                child: FloatingActionButton(
                  onPressed: updateFunc,
                  child: const Text('Update Task'),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
