import 'package:flutter/material.dart';

class NoteDelete extends StatelessWidget {
  final String noteTitle;
  const NoteDelete({super.key, required this.noteTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Warning'),
      content: Text('Do you want to delete this $noteTitle?'),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        ElevatedButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
