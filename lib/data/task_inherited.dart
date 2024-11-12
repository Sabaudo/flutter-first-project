import 'package:flutter/material.dart';
import 'package:primeiro_projeto_flutter/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited ({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    Task("Aprender Flutter e java e angular e C# e mysql e mariaDB e microsservices",'assets/images/santos.png', 1),
    Task("Aprender Java", "assets/images/java.png", 2),
    Task("Aprender C#","assets/images/c#.png", 3),
    Task("Aprender MySQL", "assets/images/mysql.png", 4),
    Task("Aprender MariaDB","assets/images/mariadb.jpg", 5)
  ];

  void newTask(String name, String img, int difficulty) {
    taskList.add(Task(name, img, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited ? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
