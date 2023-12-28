import '../classes/index.dart';

void openTodo(todo, value) {
  todo.opened = value;
}

void removeTask(Task taskname, value) {
  taskname.tasks = [
    ...taskname.tasks!.sublist(0, value),
    ...taskname.tasks!.sublist(value + 1),
  ];
}

void addNewTaskInstance(value, editTask) {
  if (value.runtimeType == List<Object>) {
    if (value[2] == 'above') {
      editTask.tasks = <TaskInstance>[
        ...editTask.tasks.sublist(0, value[0]),
        value[1],
        ...editTask.tasks.sublist(value[0])
      ];
      return;
    }

    editTask.tasks = <TaskInstance>[
      ...editTask.tasks.sublist(0, value[0] + 1),
      value[1],
      ...editTask.tasks.sublist(value[0] + 1)
    ];

    return;
  }

  editTask.tasks = <TaskInstance>[...editTask.tasks, value];
}


void openAndCloseTask(Task theTask){
  theTask.opened = !theTask.opened;
}


