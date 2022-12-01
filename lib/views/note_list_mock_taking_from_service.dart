import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter_crud_rest_api/models/note_for_listing.dart';
import 'package:flutter_crud_rest_api/services/notes_service.dart';
import 'package:flutter_crud_rest_api/views/note_delete.dart';
import 'package:flutter_crud_rest_api/views/note_modify.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {
  final String title;

  const NoteList({required this.title, super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  // final service = NotesService();
  NotesService get service => GetIt.I<NotesService>();

  List<NoteForListing> notes = [];

  // List<NoteForListing> notes = [
  //   NoteForListing(
  //     noteID: '1',
  //     noteTitle: 'Note 1',
  //     createDateTime: DateTime.now(),
  //     latestEditDateTime: DateTime.now(),
  //   ),
  //   NoteForListing(
  //     noteID: '2',
  //     noteTitle: 'Note 2',
  //     createDateTime: DateTime.now(),
  //     latestEditDateTime: DateTime.now(),
  //   ),
  //   NoteForListing(
  //     noteID: '3',
  //     noteTitle: 'Note 3',
  //     createDateTime: DateTime.now(),
  //     latestEditDateTime: DateTime.now(),
  //   ),
  //   NoteForListing(
  //     noteID: '4',
  //     noteTitle: 'Note 4',
  //     createDateTime: DateTime.now(),
  //     latestEditDateTime: DateTime.now(),
  //   ),
  // ];

  // Date Time Function
  String formatDateTime(DateTime dateTime) {
    // developer.log('log me', error: {dateTime});
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  // to get all notes

  @override
  void initState() {
    notes = service.getNotesList();
    developer.log('notes-->', error: {notes.length});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('float Btn Press-->Add Note');

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const NoteModify(
                noteID: '',
              ),
            ),
          );
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
          return Dismissible(
            key: ValueKey(notes[index].noteID),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              print('onDismissed');
            },
            confirmDismiss: (
              direction,
            ) async {
              final result = await showDialog(
                context: context,
                builder: (_) => NoteDelete(
                  noteTitle: notes[index].noteTitle ?? '',
                ),
              );
              print('confirmDismiss $result');
              return result;
            },
            // for delete need background
            background: Container(
              color: Colors.red,
              padding: const EdgeInsets.only(left: 16),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            child: ListTile(
              title: Text(
                notes[index].noteTitle ?? '',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(
                'Last edited on ${formatDateTime(notes[index].latestEditDateTime!)}',
              ),
              onTap: () {
                print('float Btn Press-->Edit Note');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => NoteModify(
                      noteID: notes[index].noteID ?? '',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
