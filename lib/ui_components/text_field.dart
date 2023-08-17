import 'package:flutter/material.dart';


class TextFieldLogin extends StatelessWidget {
  TextFieldLogin({Key? key,required this.Text,required this.controller}) : super(key: key);
  TextEditingController controller;
  final Text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(controller: controller,decoration: InputDecoration(enabledBorder: OutlineInputBorder(),hintText:Text,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide())),
      ),);
  }
}
