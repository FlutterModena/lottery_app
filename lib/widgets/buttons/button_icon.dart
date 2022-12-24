import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final Function fun;
  final Color bgColor;
  final Color fgColor;
  final IconData iconData;

  const ButtonIcon(
      {required this.fun,
      this.bgColor = Colors.red,
      this.fgColor = Colors.white,
      this.iconData = Icons.refresh,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: fgColor,
        backgroundColor: bgColor,
      ),
      onPressed: () => fun,
      child: Icon(iconData, size: 20),
    );
  }
}
