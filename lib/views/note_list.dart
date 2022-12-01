import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_rest_api/views/note_delete.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_crud_rest_api/models/note_for_listing.dart';
import 'package:flutter_crud_rest_api/services/notes_service.dart';
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
  NotesService service() => GetIt.I<NotesService>();
  late bool _isLoading = false;
  late bool error = false;
  late String errorMessage = '';
  List<NoteForListing> notes = [];

  // Date Time Function
  String formatDateTime(DateTime dateTime) {
    // developer.log('log me', error: {dateTime});

    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  // to get all notes

  @override
  void initState() {
    _getAllNotes();

    // developer.log('_apiResponse-->', error: {_apiResponse});
    super.initState();
  }

  static const APIURL = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': '21d9dc11-dcd7-4dc7-b7a7-5009eb9b0e90'};

  void _getAllNotes() {
    var url = Uri.parse('$APIURL/notes');

    setState(() {
      _isLoading = true;
    });
    var response = http.get(url, headers: headers).then((data) {
      if (data.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        // developer.log('notes-->', error: {data.body});
        final jsonData = json.decode(data.body);

        for (var item in jsonData) {
          final note = NoteForListing(
            noteID: item['noteID'],
            noteTitle: item['noteTitle'],
            createDateTime: DateTime.parse(item['createDateTime']),
            latestEditDateTime: item['latestEditDateTime'] != null
                ? DateTime.parse(item['latestEditDateTime'])
                : null,
          );
          notes.add(note);
        }
      } else {
        return setState(() {
          _isLoading = false;
          error = true;
          errorMessage = 'An error occured';
        });
      }
    }).catchError((_) => (setState(() {
          _isLoading = false;
          error = true;
          errorMessage = 'An error occured';
        })));
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
      body: Builder(builder: (_) {
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (error == true && errorMessage == 'An error occured') {
          return Center(child: Text(errorMessage));
        } else {
          return ListView.separated(
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
                    // 'Hi',
                    notes[index].noteTitle ?? '',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text(notes[index].latestEditDateTime == null
                      ? 'Last edited on ${formatDateTime(notes[index].createDateTime!)}'
                      : 'Last edited on ${formatDateTime(notes[index].latestEditDateTime!)}'),
                  onTap: () {
                    print('float Btn Press-->Edit Note');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            NoteModify(noteID: notes[index].noteID ?? ''),
                      ),
                    );
                    // .then((value) => _getAllNotes());
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
