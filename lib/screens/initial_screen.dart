import 'package:flutter/material.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  bool opacidade = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.blue,
        title: const Text('Tarefas'),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(
            milliseconds: 1000
        ),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: const [
            Task(
                "Aprender Flutter e java e angular e C# e mysql e mariaDB e microsservices",
                'assets/images/santos.png',
                1),
            Task(
                "Aprender Java",
                "assets/images/java.png",
                2),
            Task(
                "Aprender C#",
                "assets/images/c#.png",
                3),
            Task(
                "Aprender MySQL",
                "assets/images/mysql.png",
                4),
            Task(
                "Aprender MariaDB",
                "assets/images/mariadb.jpg",
                5),
            SizedBox(
              height: 90,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          opacidade = !opacidade;
        });
      },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}

