import 'package:flutter/material.dart';
import 'package:primeiro_projeto_flutter/components/loading_widget.dart';
import 'package:primeiro_projeto_flutter/components/task.dart';
import 'package:primeiro_projeto_flutter/dao/task_dao.dart';
import 'package:primeiro_projeto_flutter/screens/task_form.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                TaskDao().deleteDatabase('task');
                setState(() {});
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ))
        ],
        backgroundColor: Colors.blue,
        title: const Text(
          'Tarefas',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 90),
        child: FutureBuilder(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const LoadingWidget();
                case ConnectionState.waiting:
                  return const LoadingWidget();
                case ConnectionState.active:
                  return const LoadingWidget();
                case ConnectionState.done:
                  if (snapshot.hasData && items != null && items.isNotEmpty) {
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Task task = items[index];
                          return task;
                        });
                  }
                  return const Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 128,
                        ),
                        Text(
                          'Nenhuma tarefa disponível',
                          style: TextStyle(fontSize: 28),
                        )
                      ],
                    ),
                  );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contextNew) => TaskForm(taskContext: context)))
              .then((value) async {
            if (value == true) {
              await TaskDao().findAll();
              setState(() {
                print('Recarregando');
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
