import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imgSrcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.blue,
        title: const Text('Nova tarefa',
          style: TextStyle(color: Colors.white),)
      ),
      body: Center(
        child: Container(
          height: 650,
          width: 375,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Nome da tarefa',
                    fillColor: Colors.white70,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: difficultyController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Dificuldade',
                    fillColor: Colors.white70,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {

                    });
                  },
                  controller: imgSrcController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Imagem',
                    fillColor: Colors.white70,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                width: 72,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.blue)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    errorBuilder: (BuildContext context, Object ex, StackTrace? stackTrace) {
                      return const CircleAvatar(
                        minRadius: 10,
                        maxRadius: 30,
                        backgroundImage: AssetImage('assets/images/nophoto.png'),
                      );
                    },
                    imgSrcController.text,
                    fit: BoxFit.cover,),
                ),
              ),
              ElevatedButton(onPressed: () {
                print(nameController.text);
                print(int.parse(difficultyController.text));
                print(imgSrcController.text);
              }, child: const Text('Adicionar'))
            ],
          ),
        ),
      ),
    );
  }
}
