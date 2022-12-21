import 'dart:math';
import 'package:flutter/material.dart';

/// Schermata che permette di inserire dei nomi e di estrarne uno casuale.
class ExtractNameScreen extends StatefulWidget {
  const ExtractNameScreen({Key? key}) : super(key: key);

  @override
  State<ExtractNameScreen> createState() => _ExtractNameScreenState();
}

class _ExtractNameScreenState extends State<ExtractNameScreen> {
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

  /// Resetta lo stato dell'app.
  void _resetAll() {
    setState(() {
      _inputController.clear();
      _names.clear();
      _winnerName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estrazione"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                for (final name in _names) ...[
                  Chip(
                    label: Text(name),
                  )
                ]
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: _names.isEmpty ? 20.0 : 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: _extractWinner,
                    child: const Text("Estrai un nome"),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    onPressed: _resetAll,
                    child: const Icon(Icons.refresh, size: 20),
                  ),
                ],
              ),
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
