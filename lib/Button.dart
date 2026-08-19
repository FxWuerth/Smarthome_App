import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


Widget buttonwidget(String tx, void Function(String) onPresstCallback){
  return TextButton(
    onPressed: () {
      onPresstCallback(tx);
    },
    style: TextButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
    ),

    child: const Text('Klick'),


  );

}
