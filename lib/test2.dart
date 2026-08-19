import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(

    home: SimpleTimePicker()
));

class SimpleTimePicker extends StatefulWidget {
  const SimpleTimePicker({super.key});

  @override
  State<SimpleTimePicker> createState() => _SimpleTimePickerState();
}

class _SimpleTimePickerState extends State<SimpleTimePicker> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('24h Zeitauswahl')),
      body: Center(
        child: ElevatedButton(
          child: Text('Zeit: ${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}'),
          onPressed: () async {
            final t = await showTimePicker(
              context: context,
              initialTime: _time,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(
                    alwaysUse24HourFormat: true),
                child: child!,
              ),
            );
            if (t != null) setState(() => _time = t);
          },
        ),
      ),
    );
  }
}
