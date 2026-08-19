import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_flutter/Stateful.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter/network.dart';
class Zeitschaltsteuerung extends State<Zeitstate> {
  TimeOfDay _timeon = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeoff = const TimeOfDay(hour: 0, minute: 0);
  String _timeonS = "";
  String _timeoffS = "";
  bool _valuelight = false;
  @override
  Widget build(BuildContext context) {
   return Column(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: [
       Text("Einschalten: "),
       ElevatedButton(
       child: Text('Zeit: ${_timeon.hour.toString().padLeft(2, '0')}:${_timeon.minute.toString().padLeft(2, '0')}'),
       onPressed: () async {
         final t = await showTimePicker(
           context: context,
           initialTime: _timeon,
           builder: (context, child) => MediaQuery(
             data: MediaQuery.of(context).copyWith(
                 alwaysUse24HourFormat: true),
             child: child!,
           ),
         );
         if (t != null) setState(() => _timeon = t);
         _timeonS = Zeitumwandeln(_timeon);
       },
     ),
       Text("Ausschalten: "),
       ElevatedButton(
       child: Text('Zeit: ${_timeoff.hour.toString().padLeft(2, '0')}:${_timeoff.minute.toString().padLeft(2, '0')}'),
       onPressed: () async {
         final t = await showTimePicker(
           context: context,
           initialTime: _timeoff,
           builder: (context, child) => MediaQuery(
             data: MediaQuery.of(context).copyWith(
                 alwaysUse24HourFormat: true),
             child: child!,
           ),
         );
         if (t != null) setState(() => _timeoff = t);
         _timeoffS = Zeitumwandeln(_timeoff);
       },
     ),
       ElevatedButton(
           onPressed: () async{
             await settime(_timeonS, _timeoffS);
             },
           child: Text("Zeit Setzen")
       ),
       StreamBuilder<bool>(
         stream: getLightStatus(widget.ip),
         builder: (context, snapshot) {
           if (!snapshot.hasData) return const CircularProgressIndicator();
           _valuelight = snapshot.data!;
          return Icon(
            Icons.lightbulb,
            color: _valuelight ? Colors.yellow : Colors.grey,
          );
         },
       )
     ],);
  }

  Zeitumwandeln(TimeOfDay time){
    // Ruft die Stunde ab (z.B. 8 oder 15) und formatiert sie auf 2 Stellen
    String stunde = time.hour.toString().padLeft(2, '0');

    // Ruft die Minute ab (z.B. 30 oder 5) und formatiert sie auf 2 Stellen
    String minute = time.minute.toString().padLeft(2, '0');
    return stunde + minute;
  }


  Future<void> settime(String on, String off) async {
    final url = Uri.parse('http://192.168.136.124/set');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body:  jsonEncode({'stron': on, 'stroff': off}),
      );
      if (response.statusCode == 200) {
        print('Gesendet erfolgreich: ${response.body}');
      } else {
        print('Fehler: ${response.statusCode}');
      }
    } catch (e) {
      print("Fehler: $e");
    }

  }
}