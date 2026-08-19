import 'package:app_flutter/ZeitSchaltSteuerung.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/light.dart';
import 'package:app_flutter/Stateful.dart';
import 'package:app_flutter/Füllstandssensor.dart';





Widget Licht(String name){

  return Scaffold(
       appBar: AppBar(
         title: Text(name),
         backgroundColor: Colors.yellow,
       ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lightstate(),
            ],
          )
      ],
    ),
  );
}
Widget Steuerung(String name){
  return Scaffold(
    appBar: AppBar(
      title: Text(name),
      backgroundColor: Colors.green,

    ),
  );
}
Widget Auslesen(String name){
  return Scaffold(
    appBar: AppBar(
      title: Text(name),
      backgroundColor: Colors.blue,

    ),
  );
}
Widget Wasserstand(String Name, String Ip){

    return SensorPage(
        name: Name,
        ip: Ip
    );

}

Widget ZeitschaltUhr_LichterKette(String name, String ip){
  return Scaffold(
    appBar: AppBar(
      title: Text(name),
      backgroundColor: Colors.blue
    ),
    body: Column(
    mainAxisAlignment: MainAxisAlignment.center,

    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Zeitstate(ip: ip)
        ],
      )
    ],
  )

  );
}
Widget Error1(){
    return Scaffold(

    );
}

