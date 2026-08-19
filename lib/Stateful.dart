import 'package:flutter/material.dart';
import 'package:app_flutter/main.dart';
import 'package:app_flutter/Füllstandssensor.dart';
import 'package:app_flutter/NewDevice.dart';
import 'package:app_flutter/Layout.dart';
import 'package:app_flutter/DevicePages.dart';
import 'package:app_flutter/light.dart';
import 'package:app_flutter/ZeitSchaltSteuerung.dart';

class generatorW extends StatefulWidget{
  const generatorW({super.key});
  @override
  generator createState() => generator();
}

class SensorPage extends StatefulWidget {
  final String name;
  final String ip;
  const SensorPage({super.key, required this.name, required this.ip});


@override
SensorPageState createState() => SensorPageState();
}

class NewDevice extends StatefulWidget{
  const NewDevice({super.key});

  @override
  SetNewDevice createState() => SetNewDevice();

}
class Lightstate extends StatefulWidget{
  const Lightstate({super.key});

  @override
  Light createState() => Light();

}

class Zeitstate extends StatefulWidget{

  final String ip;
  const Zeitstate({super.key, required this.ip});
  @override
  Zeitschaltsteuerung createState() => Zeitschaltsteuerung();
}

