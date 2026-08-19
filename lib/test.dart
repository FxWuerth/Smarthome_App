import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Startseite()));
}

class Startseite extends StatefulWidget {
  @override
  _StartseiteState createState() => _StartseiteState();
}

class _StartseiteState extends State<Startseite> {
  String _eingabe = "Noch nichts eingegeben";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Startseite")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Ergebnis: $_eingabe"),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Zur Eingabe-Seite"),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EingabeSeite()),
                );

                if (result != null) {
                  setState(() {
                    _eingabe = result;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EingabeSeite extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Eingabe-Seite")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Gib etwas ein"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Zurück mit Eingabe"),
              onPressed: () {
                Navigator.pop(context, _controller.text); // Wert zurückgeben
              },
            ),
          ],
        ),
      ),
    );
  }
}
