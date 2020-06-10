import 'package:flutter/material.dart';
class RoundButoon extends StatelessWidget {
  Color color;
  String name;
  Function f;
  RoundButoon({this.color,this.name,this.f});
  @override
  Widget build(BuildContext context) {
    return Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
    elevation: 7.0,
    child: MaterialButton(
    onPressed: f,
    minWidth: 300.0,
    height: 42.0,
    child: Text(
    name,
    style: TextStyle(
      color: Colors.white
    ),),

    ));
  }
}

