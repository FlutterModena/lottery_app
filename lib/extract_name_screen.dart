import 'dart:math';
import 'package:flutter/material.dart';

class ExtractNameScreen extends StatefulWidget {
  const ExtractNameScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ExtractNameScreenState();
}

class ExtractNameScreenState extends State<ExtractNameScreen> {
  /// Controller per il [TextField] che permette di inserire un nome.
  late final TextEditingController _inputController;

  /// Lista dei nomi inseriti.
  final _names = <String>[];

  /// Generatore di numeri casuali.
  final _random = Random();

  /// Nome estratto.
  String? _winnerName;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  /// Mostra un [SnackBar] con il testo [text].
  void _showSnackBar(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  /// Aggiunge un nome alla lista dei nomi.
  void _addName() {
    final name = _inputController.text;

    if (name.isEmpty) {
      _showSnackBar(context, text: "Inserisci un nome");
      return;
    }

    setState(() {
      _inputController.clear();
      _names.add(name);
    });
  }

  /// Estrae un nome casuale dalla lista dei nomi.
  void _extractWinner() {
    if (_names.isEmpty) {
      _showSnackBar(context, text: "Inserisci almeno un nome");
      return;
    }

    final winnerIndex = _random.nextInt(_names.length);

    setState(() {
      _winnerName = _names[winnerIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estrazione libro"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      onSubmitted: (_) => _addName(),
                      decoration: const InputDecoration(
                        hintText: "Nome persona",
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 24,
                    onPressed: _addName,
                    icon: const Icon(Icons.send),
                  )
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
              onPressed: _extractWinner,
              child: const Text("Estrai un nome"),
            ),
            if (_winnerName != null) ...[
              Wrap(
                children: [
                  Text(
                    "The winner is $_winnerName",
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
