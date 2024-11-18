import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:primeiro_projeto_flutter/components/task.dart';
import 'package:primeiro_projeto_flutter/dao/task_dao.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imgSrcController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    return value != null && value.isEmpty;
  }

  bool difficultyValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (int.parse(value) < 1 || int.parse(value) > 5) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              'Nova tarefa',
              style: TextStyle(color: Colors.white),
            )),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? nome) {
                        if (valueValidator(nome)) {
                          return 'Insira um nome para a tarefa!';
                        }
                        return null;
                      },
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
                      validator: (difficulty) {
                        if (difficultyValidator(difficulty)) {
                          return 'Insira uma dificuldade entre 1 e 5!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
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
                        setState(() {});
                      },
                      validator: (url) {
                        if (valueValidator(url)) {
                          return 'Insira uma URL de imagem!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
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
                        border: Border.all(width: 2, color: Colors.blue)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        errorBuilder: (BuildContext context, Object ex,
                            StackTrace? stackTrace) {
                          return const CircleAvatar(
                            minRadius: 10,
                            maxRadius: 30,
                            backgroundImage:
                                AssetImage('assets/images/nophoto.png'),
                          );
                        },
                        imgSrcController.text,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          TaskDao().save(Task(
                            nome:  nameController.text,
                            foto:  imgSrcController.text,
                            dificuldade: int.parse(difficultyController.text),
                            nivel: 0,
                            mastery: 0,
                          ));

                          // TaskInherited.of(widget.taskContext).newTask(
                          //     nameController.text,
                          //     imgSrcController.text,
                          //     int.parse(difficultyController.text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Criando nova tarefa')),
                          );
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text('Adicionar'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
