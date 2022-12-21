import 'dart:math';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> names = [];
  String currentName = "";
  var random = Random();
  String? winnerName;

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
                          names.add(currentName);
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
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(names[index]),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                var n = random.nextInt(names.length);

                setState(() {
                  winnerName = names[n];
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
