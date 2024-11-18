import 'package:flutter/material.dart';
import 'package:primeiro_projeto_flutter/dao/task_dao.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;


  Task({
    required this.nome,
    required this.foto,
    required this.dificuldade,
    required this.nivel,
    required this.mastery,
    super.key,
  });

  int nivel;
  int mastery;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.black
  ];
  Color colorLevel = Colors.blue;

  bool assetOrNetwork() {
    return !widget.foto.contains('http');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorLevel = colors[widget.mastery];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: colorLevel,
            ),
          ),
          Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 72,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: assetOrNetwork()
                              ? Image.asset(widget.foto, fit: BoxFit.cover)
                              : Image.network(widget.foto, fit: BoxFit.cover),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        Difficulty(difficultyLevel: widget.dificuldade),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)))),
                            onLongPress: () => showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) =>
                                    AlertDialog(
                                      title: const Text('Exclusão'),
                                      content: const Text(
                                        'Deseja excluir esta tarefa?'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () => Navigator.pop(
                                                dialogContext, 'Cancelar'),
                                            child: const Text('Cancelar')),
                                        TextButton(
                                            onPressed: () {
                                              TaskDao().delete(widget.nome);
                                              Navigator.pop(dialogContext);
                                            },
                                            child: const Text('OK'))
                                      ],
                                    )),
                            onPressed: () {
                              setState(() {
                                widget.nivel++;
                                updateColor();
                              });
                              // print('Evoluiu para o nivel $nivel');
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.arrow_drop_up,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                Text(
                                  'UP',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        backgroundColor: Colors.black38,
                        value: (widget.dificuldade > 0)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                    Text(
                      'Nivel: ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateColor() {
    double level = (widget.nivel / widget.dificuldade);
    if (level > 10 && widget.mastery < 6) {
      widget.mastery++;
      widget.nivel = 0;
      colorLevel = colors[widget.mastery];
    }
    TaskDao().save(widget);
  }
}
