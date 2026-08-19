import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_flutter/network.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter/Stateful.dart';

class SensorPageState extends State<SensorPage> {
  late Future<http.Response> _futureSensorData;


  @override
  void initState() {
    super.initState();
    _futureSensorData = SensorValue(widget.ip); // Initialisierung
  }
  Widget sensorBuild() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(widget.name),
        ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: const Text("Der Wasser behälter ist so weit gefüllt:"),
              subtitle: FutureBuilder<http.Response>(
                  future: _futureSensorData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      int statusCode = snapshot.data!.statusCode;
                      if (statusCode == 200 && snapshot.data!.body != null) {
                        return Text(SValue
                            .fromJson(jsonDecode(snapshot.data!.body))
                            .temp);
                      }
                      return Text('$statusCode');
                    }
                    else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }
              ),
            )
          ]
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: reloadData,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.refresh)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   return sensorBuild();
  }


  void reloadData() {
    setState(() {
      _futureSensorData = SensorValue(widget.ip);
    });
  }
}

class SValue{
  final String temp;

  SValue({required this.temp});

  factory SValue.fromJson(Map<String, dynamic> json){
    return SValue(
        temp: json['temp'].toString()
    );
  }
}

