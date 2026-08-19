import 'dart:convert';
import 'package:app_flutter/NewDevice.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/Stateful.dart';
import 'package:app_flutter/DevicePages.dart';
import 'package:app_flutter/Füllstandssensor.dart';
import 'package:shared_preferences/shared_preferences.dart';


class generator extends State<generatorW> {

  List<DeviceData> device = [];

  Future<void> saveDeviceList(List<DeviceData> deviceList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
    deviceList.map((device) => jsonEncode(device.toJson())).toList();
    await prefs.setStringList('deviceList', jsonList);
  }
  Future<List<DeviceData>> loadDeviceList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('deviceList');
    if (jsonList == null) return [];
    return jsonList
        .map((jsonStr) => DeviceData.fromJson(jsonDecode(jsonStr)))
        .toList();
  }
  Future<void> _loadDeviceList() async {
    List<DeviceData> loadedDevices = await loadDeviceList();
    setState(() {
      device = loadedDevices; // Aktualisiere den UI-State
    });
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _loadDeviceList();
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smarthome"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: ListView.builder(
                itemCount: device.length,
                itemBuilder: (context, index) {
                  return createCard(device[index]);
                }
            )
            ),
          ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () => addNewDevice(context),
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 20,
          )

      ),
    );
  }




  void addNewDevice(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return const NewDevice();
        }));
    if (result != null) {
      setState(() {

        device.add(result);
        saveDeviceList(device);

      });
    }
  }

  Card createCard(DeviceData dd) {
    IconData icon;
    Color color;
    switch (dd.type)
    {
      case "Licht":
        icon = Icons.lightbulb;
        color = Colors.yellow;
        break;
      case "Steuerung":
        icon = Icons.settings_remote;
        color = Colors.green;
        break;
      case "Auslesen":
        icon = Icons.sensors;
        color = Colors.blue;
        break;
      case "Wasserstand":
        icon = Icons.water_drop;
        color = Colors.blue;
      default:
        icon = Icons.device_unknown;
        color = Colors.grey;
    }

    ipbearbeiten() {
      String ipadresse = dd.ip.substring(0, 3) + "."+ dd.ip.substring(3);
      ipadresse = ipadresse.substring(0,7) + "." + ipadresse.substring(7);
      ipadresse = ipadresse.substring(0,11) + "." + ipadresse.substring(11);
      return ipadresse;
    }
    return Card(
        child: ListTile(
        title: Text(dd.name),
        subtitle: Text(ipbearbeiten()),
        leading: Icon(icon, color: color),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return choosePage(dd.type, dd.name, ipbearbeiten());
          }));
        },
       trailing: IconButton(
           onPressed: () {
             for(int i =0; i < device.length; i++){
                 if(device[i] == dd){
                    setState(() {
                      device.removeAt(i);
                    });
                 }
         }
        },
           icon: Icon(Icons.delete),
           hoverColor: Colors.red,
       ),
    ));
  }
  Widget choosePage(String type, String name, String ip) {
    switch (type) {
      case "Zeitschaltuhr":
        return ZeitschaltUhr_LichterKette(name, ip);
      case "Licht":
        return Licht(name);
      case "Steuerung":
        return Steuerung(name);
      case "Auslesen":
        return Auslesen(name);
      case "Wasserstand":
        return Wasserstand(name, ip);
      default:
        return Error1();
    }
}

}

