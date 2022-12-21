import 'dart:math';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> _names = [];
  String currentName = "";
  var random = Random();
  String? winnerName;

  /// Mostra un [SnackBar] con il testo [text].
  void _showSnackBar(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        currentName = value;
                      },
                      decoration:
                          const InputDecoration(hintText: "Nome persona"),
                    ),
                  ),
                  IconButton(
                      iconSize: 24,
                      onPressed: () {
                        setState(() {
                          _names.add(currentName);
                        });
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _names.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(_names[index]),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                if (_names.isEmpty) {
                  _showSnackBar(context, text: "Inserisci almeno un nome");
                  return;
                }

                var n = random.nextInt(_names.length);

                setState(() {
                  winnerName = _names[n];
                });
              },
              child: const Text("Estrai un nome"),
            ),
            if (winnerName != null)
              Wrap(children: [
                Text(
                  "The winner is $winnerName",
                  style: const TextStyle(fontSize: 30),
                ),
              ])
          ],
        ),
      ),
    );
  }
}
