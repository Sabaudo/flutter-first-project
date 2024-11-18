import 'package:primeiro_projeto_flutter/components/task.dart';
import 'package:primeiro_projeto_flutter/config/database_config.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String _tablename = 'task';
  static const String _nome = 'nome';
  static const String _dificuldade = 'dificuldade';
  static const String _image = 'image';
  static const String _nivel = 'nivel';
  static const String _maestria = 'maestria';

  static const String tableSql = 'CREATE TABLE IF NOT EXISTS $_tablename('
      '$_nome varchar(100), '
      '$_dificuldade integer, '
      '$_image varchar(255), '
      '$_nivel integer, '
      '$_maestria integer)';

  save(Task task) async {
    final Database db = await getDatabase();
    var itemExists = await find(task.nome);

    Map<String, dynamic> taskMap = toMap(task);

    if (itemExists.isEmpty) {
      return await db.insert(_tablename, taskMap);
    } else {
      print('A tarefa já existe!');
      return await db.update(_tablename, taskMap,
          where: '$_nome = ?', whereArgs: [task.nome]);
    }
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablename);

    return toList(result);
  }

  Future<List<Task>> find(String nome) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(_tablename, where: '$_nome = ?', whereArgs: [nome]);

    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> taskMap) {
    final List<Task> tasks = [];

    for (Map<String, dynamic> tl in taskMap) {
      final Task task = Task(
        nome:  tl[_nome],
        foto:  tl[_image],
        dificuldade: tl[_dificuldade],
        nivel: tl[_nivel],
        mastery: tl[_maestria],
      );

      // Task task = Task(
      //     tl[_nome], tl[_image], tl[_dificuldade],
      //     nivel: tl[_nivel], maestria: tl[_maestria]);
      tasks.add(task);
    }

    return tasks;
  }

  delete(String nome) async {
    final Database db = await getDatabase();
    return db.delete(_tablename, where: '$_nome = ?', whereArgs: [nome]);
  }

  Future<void> deleteDatabase(String databaseName) async {
    final Database db = await getDatabase();
    //await databaseFactory.deleteDatabase(databaseName);
    await db.execute('DROP TABLE IF EXISTS $databaseName');
    print('Banco de dados deletado com sucesso.');
    await db.close();
  }

  Map<String, dynamic> toMap(Task task) {
    final Map<String, dynamic> taskMap = {};
    taskMap[_nome] = task.nome;
    taskMap[_dificuldade] = task.dificuldade;
    taskMap[_image] = task.foto;
    taskMap[_nivel] = task.nivel;
    taskMap[_maestria] = task.mastery;
    return taskMap;
  }
}
