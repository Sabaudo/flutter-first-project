
import 'package:primeiro_projeto_flutter/components/task.dart';
import 'package:primeiro_projeto_flutter/config/database_config.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String _tablename = 'task';
  static const String _nome = 'nome';
  static const String _dificuldade = 'dificuldade';
  static const String _image = 'image';

  static const String tableSql = 'CREATE TABLE IF NOT EXISTS $_tablename('
      '$_nome varchar(100), '
      '$_dificuldade integer, '
      '$_image varchar(255))';

  save(Task task) async {
    final Database db = await getDatabase();
    var itemExists = await find(task.nome);

    Map<String, dynamic> taskMap = toMap(task);

    if(itemExists.isEmpty) {
      return await db.insert(_tablename, taskMap);
    } else {
      print('A tarefa já existe!');
      return await db.update(_tablename, taskMap, where: '$_nome = ?',
          whereArgs: [task.nome]);
    }
  }

  Future<List<Task>> findAll() async {
   final Database db = await getDatabase();
   final List<Map<String, dynamic>> result = await db.query(_tablename);

   return toList(result);
  }

  Future<List<Task>> find(String nome) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablename, where: '$_nome = ?',
        whereArgs: [nome]);

    return toList(result);
  }
  
  List<Task> toList(List<Map<String, dynamic>> taskMap) {
    final List<Task> tasks = [];

    for (Map<String, dynamic> tl in taskMap) {
      Task task = Task(tl[_nome], tl[_image], tl[_dificuldade]);
      tasks.add(task);
    }

    return tasks;
  }

  delete(String nome) async {
    final Database db = await getDatabase();
    return db.delete(_tablename, where: '$_nome = ?', whereArgs: [nome]);
  }

  Map<String, dynamic> toMap(Task task) {
    final Map<String, dynamic> taskMap = {};
    taskMap[_nome] = task.nome;
    taskMap[_dificuldade] = task.dificuldade;
    taskMap[_image] = task.foto;
    return taskMap;
  }

}