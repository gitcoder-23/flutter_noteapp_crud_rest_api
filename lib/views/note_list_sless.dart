import 'package:flutter/material.dart';
import 'package:flutter_crud_rest_api/models/note_for_listing.dart';

class NoteList extends StatelessWidget {
  final String title;
  final notes = [
    NoteForListing(
      noteID: '1',
      noteTitle: 'Note 1',
      createDateTime: DateTime.now(),
      latestEditDateTime: DateTime.now(),
    ),
    NoteForListing(
      noteID: '2',
      noteTitle: 'Note 2',
      createDateTime: DateTime.now(),
      latestEditDateTime: DateTime.now(),
    ),
    NoteForListing(
      noteID: '3',
      noteTitle: 'Note 3',
      createDateTime: DateTime.now(),
      latestEditDateTime: DateTime.now(),
    ),
    NoteForListing(
      noteID: '4',
      noteTitle: 'Note 4',
      createDateTime: DateTime.now(),
      latestEditDateTime: DateTime.now(),
    ),
  ];
  NoteList({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('float Btn Press-->');
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => const Divider(
          height: 1,
          color: Colors.green,
        ),
        itemCount: notes.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(
              'Hello List',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: const Text('Last edited on 21Nov'),
          );
        },
      ),
    );
  }
}
