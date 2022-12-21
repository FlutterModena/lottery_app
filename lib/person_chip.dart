import 'package:flutter/material.dart';

class PersonChip extends StatelessWidget {
  const PersonChip({
    Key? key,
    required this.isWinner,
    required this.name,
    required this.canDelete,
    required this.onDeleteName,
  }) : super(key: key);

  final bool isWinner;
  final String name;
  final bool canDelete;
  final void Function(String name) onDeleteName;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: isWinner ? Colors.green : null,
      deleteButtonTooltipMessage: "Rimuovi $name",
      deleteIcon: canDelete
          ? const Icon(
              Icons.cancel,
              size: 20,
            )
          : null,
      onDeleted: canDelete ? () => onDeleteName(name) : null,
      label: Text(
        name,
        style: TextStyle(
          color: isWinner ? Colors.white : null,
        ),
      ),
    );
  }
}
