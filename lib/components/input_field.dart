import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  String nome;
  String dificuldade;
  String imgSrc;

  TextEditingController nameController = TextEditingController();

  InputField(this.nome, this.dificuldade, this.imgSrc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: nameController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: nome,
          fillColor: Colors.white70,
          filled: true,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
