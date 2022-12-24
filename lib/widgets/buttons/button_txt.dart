import 'package:flutter/material.dart';

class ButtonTxt extends StatelessWidget {
  final Function fun;
  final String text;
  final Color bgColor;
  final Color fgColor;
  const ButtonTxt(
      {required this.fun,
      this.bgColor = Colors.blue,
      this.fgColor = Colors.white,
      this.text = "Estrai un nome",
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: fgColor,
        backgroundColor: bgColor,
      ),
      onPressed: () => fun(),
      child: Text(text),
    );
  }
}
