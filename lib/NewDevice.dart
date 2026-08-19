import 'package:flutter/material.dart';
import 'package:app_flutter/Stateful.dart';
import 'package:app_flutter/Layout.dart';
import 'package:app_flutter/DevicePages.dart';
import 'package:flutter/services.dart';


class DeviceData{
  final String name;
  final String ip;
  final String type;

  DeviceData(this.name, this.ip, this.type);
  Map<String, dynamic> toJson() => {
    'name': name,
    'ip': ip,
    'type': type,
  };

  factory DeviceData.fromJson(Map<String, dynamic> json) => DeviceData(
    json['name'],
    json['ip'],
    json['type'],
  );
}
class SetNewDevice extends State<NewDevice> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _eingabeN = '';
  String _eingabeA = '';
  String? _dropdownvalue;


  final List<String> _options = ['Licht', 'Steuerung', 'Auslesen', 'Wasserstand', 'Zeitschaltuhr'];

  void _bestaetigen() {
    setState(() {
      _eingabeN = _controller1.text;
      _eingabeA = _controller2.text;

      Navigator.pop(context, DeviceData(_eingabeN, _eingabeA, _dropdownvalue?? ""));
    });
    print(_eingabeN);
    print(_eingabeA);
    print(_dropdownvalue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Device'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                  child: TextField(
                    controller: _controller1,
                    decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder()
                    ),

                  )
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                    controller: _controller2,
                    decoration: InputDecoration(
                        labelText: "IP-Adresse",
                        border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  )
              )
            ],
          ),
          DropdownButton(
              hint: Text('Bitte Wählen'),
              value: _dropdownvalue,
              items: _options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownvalue = newValue;
                });
              }
          ),

          ElevatedButton(
              onPressed: _bestaetigen,
              child: Text('Bestätigen')
          )
        ],
      ),
    );
  }


  }




