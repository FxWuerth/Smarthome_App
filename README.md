# Smarthome App

Eine mit **Flutter** entwickelte Smart-Home-App, die selbstgebaute **ESP32**-Geräte im heimischen WLAN steuert und ausliest. Die App ist die Bedienoberfläche, die ESP32-Mikrocontroller übernehmen die Hardware (Relais, Sensoren, Lichter).

## Was die App macht

- **Geräte verwalten:** Auf der Startseite lassen sich Geräte per `+`-Button hinzufügen (Name, IP-Adresse, Typ) und wieder löschen. Die Geräteliste wird lokal auf dem Handy gespeichert (`shared_preferences`) und ist nach einem Neustart wieder da.
- **Licht schalten:** Ein Gerät vom Typ *Licht* schaltet per Tastendruck eine Lampe ein oder aus.
- **Wasserstand auslesen:** Ein *Wasserstand*-Gerät fragt einen Füllstandssensor ab und zeigt an, wie weit der Wasserbehälter gefüllt ist (mit Aktualisieren-Button).
- **Zeitschaltuhr:** Für eine Lichterkette lassen sich eine Ein- und eine Ausschaltzeit einstellen und an den ESP32 senden. Der aktuelle Lichtstatus wird live angezeigt.

## Kommunikation mit dem ESP32

Die App und die ESP32-Geräte reden über einfache **HTTP-Anfragen** im lokalen Netzwerk miteinander. Jedes Gerät hat eine eigene IP-Adresse und stellt folgende Endpunkte bereit:

| Methode | Endpunkt | Funktion |
|---------|----------|----------|
| `GET`   | `/on`    | Gerät einschalten (z. B. Licht an) |
| `GET`   | `/off`   | Gerät ausschalten |
| `GET`   | `/value` | Aktuellen Wert abfragen (Sensorwert / Status als JSON) |
| `POST`  | `/set`   | Zeiten für die Zeitschaltuhr senden (`{"stron": "...", "stroff": "..."}`) |

Der Statuswert der Zeitschaltuhr wird im Sekundentakt abgefragt, sodass die Anzeige in der App immer aktuell ist.

## Technik

- **Flutter / Dart** für die App
- **http**-Package für die REST-Kommunikation
- **shared_preferences** zum lokalen Speichern der Geräteliste
- **ESP32** als WLAN-fähiger Mikrocontroller mit eigenem HTTP-Server

## Starten

```bash
flutter pub get
flutter run
```

> Hinweis: Damit die App funktioniert, müssen sich Handy und ESP32-Geräte im selben WLAN befinden. Die IP-Adressen der Geräte werden beim Hinzufügen in der App eingetragen.

---

*Privates Lernprojekt zum Thema IoT & App-Entwicklung.*
