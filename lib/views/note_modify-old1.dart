import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class NoteModify extends StatelessWidget {
  final String noteID;

  // id ops Here
  bool get isEditing => noteID != '';

  const NoteModify({required this.noteID, super.key});

  void main() {
    developer.log('noteID', error: {noteID});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(!isEditing ? 'Create Note' : 'Edit Note'),
        // title: Text(noteID == '' ? 'Create Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                // hintText: 'Note Title',
                labelText: 'Note Title',
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              height: 8,
            ),
            const TextField(
              decoration: InputDecoration(
                // hintText: 'Note Content',
                labelText: 'Note Content',
              ),
            ),

            Container(height: 20),

            SizedBox(
              width: double.infinity,
              height: 35,
              child: ElevatedButton(
                onPressed: () => {
                  print('Submit'),
                  if (isEditing)
                    {
                      // Edit Ops
                      Navigator.of(context).pop(),
                    }
                  else
                    {
                      // Add Ops
                      Navigator.of(context).maybePop(),
                    }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
            Container(height: 20),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: ElevatedButton(
                onPressed: () => {print('Reset->')},
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
