import 'package:flutter/material.dart';
import 'package:app_flutter/Stateful.dart';
import 'package:app_flutter/Layout.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My APP for Water',
      home: generatorW(),
    );
  }
}




