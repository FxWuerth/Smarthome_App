
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



Future <http.Response> SensorValue(String ip) async {
  final response = await http.get(Uri.parse("http://$ip/value"));
  return response;
}



Stream<bool> getLightStatus(String ip) async* {
  while (true) {
    try {
      final url = Uri.parse("http://$ip/value");
      final response = await http.get(url).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        yield data['value'] == true; // 👈 Wert an Stream senden
      } else {
        yield false; // oder Fehlerwert senden
      }
    } on TimeoutException{
      print("Timeout – keine Verbindung zu $ip");
      yield false;
    }
    catch (e) {
      print("Fehler beim Abrufen: $e");
      yield false; // Fehlerfall
    }

    // Warte 1 Sekunde bis zur nächsten Abfrage
    await Future.delayed(const Duration(seconds: 1));
  }
}
