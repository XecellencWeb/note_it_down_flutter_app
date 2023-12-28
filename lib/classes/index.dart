class TaskInstance {
  String? name;
  String? description;
  String? picture;

  TaskInstance({this.name, this.description, this.picture});

  static fromMap({required Map map}) => TaskInstance(
        name: map['name'],
        description: map['description'],
        picture: map['picture'].toString(),
      );

  static toMap({required TaskInstance instance}) => ({
        'name': instance.name,
        'description': instance.description,
        'picture': instance.picture,
      });
}

//Task Class

class Task {
  String? id;
  String? name;
  String? description;

  bool? taskCreated = false;
  bool opened;
  List tasks;

  Task({
    this.id,
    this.name,
    this.description,
    this.opened = false,
    List? tasks,
  }) : tasks = tasks ?? [];

  static Task fromMap({required Map map}) => Task(
        id: map['_id'],
        name: map['name'],
        description: map['description'],
        tasks: map['tasks']
            .map((task) => TaskInstance.fromMap(map: task))
            .toList(),
      );

  static toMap({required Task task}) => ({
        'name': task.name,
        'description': task.description,
        'tasks':
            task.tasks.map((tsk) => TaskInstance.toMap(instance: tsk)).toList(),
      });
}

//user class

class User {
  String? id;
  String name = '';
  String title = '';
  String gender = '';
  String? password;
  String? picture;
  int? numberOfTasksCreated;

  User(
      {this.id,
      required this.name,
      required this.title,
      required this.gender,
      this.picture,
      this.password,
      this.numberOfTasksCreated});

  static User fromMap({required Map map}) => User(
        id: map['_id'],
        name: map['name'],
        title: map['title'],
        gender: map['gender'].toString(),
        picture: map['picture'].toString(),
        numberOfTasksCreated: map['numberOfTasksCreated'],
      );

  static Map<String, dynamic> toMap({required User user}) => ({
        if (user.id != null) '_id': user.id,
        'name': user.name.toString(),
        'title': user.title.toString(),
        'gender': user.gender.toString(),
        'password': user.password.toString(),
        'picture': user.picture.toString(),
      });
}
