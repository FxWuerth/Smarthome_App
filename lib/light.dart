import 'package:flutter/material.dart';
import 'package:app_flutter/Stateful.dart';
import 'package:http/http.dart' as http;
class Light extends State<Lightstate> {

  bool status = false;

  void lichteinausschlaten() {
    setState(() {
      status = !status;
      lampeausschalten();
      print(status);
    });
  }

  isteinaus() {
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(

          icon: Icon(Icons.lightbulb),
          color: isteinaus() ? Colors.yellow : Colors.grey,
          iconSize: 100,
          onPressed: () => lichteinausschlaten(),

        ),
      ],
    );
  }

  void lampeausschalten() async {
    final urlon = Uri.parse("http://192.168.136.144/on");
    final urloff = Uri.parse("http://192.168.136.144/off");

    try{
      if(isteinaus()){
      final response = await http.get(urlon);
      }else{
        final response = await http.get(urloff);
      }
    }catch(e){
      print("Felhler");
    }
  }
}
