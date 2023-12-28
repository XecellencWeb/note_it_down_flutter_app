import 'package:flutter/material.dart';
import 'package:task_manager_app/components/featured/one_task_instance.dart';
import 'package:task_manager_app/components/featured/to_add_new_process.dart';
import 'package:task_manager_app/constants/names.dart';
import 'package:task_manager_app/pages/edit_task.dart';
import '../create_component/form.dart';
import '../../classes/index.dart';
import '../../pages/describe_task.dart';

class OneTask extends StatefulWidget {
  final Task task;
  final List taskInstance;
  final bool isEditMode;
  final bool hasOwner;
  final String? ownerId;
  
  final VoidCallback openTaskViewer;
  final Function(TaskInstance instance, bool isWritingMode, int index,
      bool isAbove, bool removing)? submitFunc;

  const OneTask({
    super.key,
    required this.task,
    required this.taskInstance,
    required this.openTaskViewer,
    this.isEditMode = true,
    this.hasOwner = false,
    this.ownerId,
    this.submitFunc,
  });

  @override
  State<OneTask> createState() => _OneTaskState();
}

class _OneTaskState extends State<OneTask> {
  bool isAddingNewProcess = false;
  final TextEditingController currentName = TextEditingController();
  final TextEditingController currentDesc = TextEditingController();
  int editingIndex = 0;
  bool writing = true;
  bool isAbove = false;
  bool isRemoving = false;
  dynamic instance;

  void _submitFunc() {
    widget.submitFunc!(
        TaskInstance(name: currentName.text, description: currentDesc.text),
        writing,
        editingIndex,
        isAbove,
        isRemoving);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.openTaskViewer,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 251, 239, 253),
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 123, 2, 145),
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.task.name.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Icon(widget.task.opened == false
                      ? Icons.arrow_downward_sharp
                      : Icons.arrow_upward_sharp)
                ],
              ),
            ),
          ),
          if (widget.task.opened == true)
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.description.toString()),
                  Container(
                    margin: const EdgeInsets.only(top: 7, bottom: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.task.tasks.map((tsk) {
                        int index = widget.task.tasks.indexOf(tsk);
                        return OneTaskInstance(
                            addOnTop: () {
                              writing = true;
                              isRemoving = false;
                              editingIndex = index;
                              isAbove = true;
                              setState(() {});
                            },
                            addUnder: () {
                              writing = true;
                              isRemoving = false;
                              editingIndex = index;
                              isAbove = false;
                            },
                            removeFunc: () {
                              
                              editingIndex = index;
                              isRemoving = true;
                              _submitFunc();
                            },
                            editFunc: () {
                              isRemoving = false;
                              writing = false;
                              editingIndex = index;
                              currentName.text = tsk.name.toString();
                              currentDesc.text = tsk.description.toString();

                              setState(() {});
                            },
                            isEditMode: widget.isEditMode,
                            instanceIndex: index,
                            maxLength: widget.task.tasks.length,
                            instance: tsk);
                      }).toList(),
                    ),
                  ),
                  if (widget.isEditMode)
                    OutlinedButton(
                      onPressed: () {
                        isRemoving = false;
                        isAbove = false;
                        writing = true;
                        editingIndex = widget.task.tasks.length;
                        isAddingNewProcess = true;
                        
                        setState(() {});
                      },
                      child: const Text('Add new instance'),
                    ),
                  if(widget.hasOwner)
                  OutlinedButton(onPressed: ()=>{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> EditTask(editableTask: widget.task)))
                  }, child:const Text('Edit Task')),
                  if (isAddingNewProcess)
                    NewProcessAdder(
                      nameController: currentName,
                      descController: currentDesc,
                      submitFunction: _submitFunc,
                    )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
