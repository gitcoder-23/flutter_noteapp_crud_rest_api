import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_rest_api/models/note_for_listing.dart';
import 'package:flutter_crud_rest_api/models/note_insert.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:flutter_crud_rest_api/services/notes_service.dart';
import 'package:get_it/get_it.dart';

class NoteModify extends StatefulWidget {
  final String noteID;

  const NoteModify({required this.noteID, super.key});

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  NotesService service() => GetIt.I<NotesService>();

  static const APIURL = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': '21d9dc11-dcd7-4dc7-b7a7-5009eb9b0e90'};

  NotesService get notesService => GetIt.I<NotesService>();
  // id ops Here
  bool get isEditing => widget.noteID != '';
  late String mainNoteId = widget.noteID;
  String errorMessage = '';
  late bool error = false;
  late SingleNote noteData = {} as SingleNote;
  late bool _isLoading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool texterror = false;

  void _getSingleNote() {
    setState(() {
      _isLoading = true;
    });
    if (mainNoteId != '') {
      var url = Uri.parse('$APIURL/notes/$mainNoteId');
      developer.log('single-url-->', error: {url});
      setState(() {
        _isLoading = true;
      });
      var response = http.get(url, headers: headers).then((data) {
        if (data.statusCode == 200) {
          setState(() {
            _isLoading = false;
          });

          final jsonData = json.decode(data.body);

          final singleNoteData = SingleNote(
            noteID: jsonData['noteID'],
            noteTitle: jsonData['noteTitle'],
            noteContent: jsonData['noteContent'],
            createDateTime: DateTime.parse(jsonData['createDateTime']),
            latestEditDateTime: jsonData['latestEditDateTime'] != null
                ? DateTime.parse(jsonData['latestEditDateTime'])
                : null,
          );
          noteData = singleNoteData;
          developer.log('singleNoteData-->', error: {noteData.noteID});
          _titleController.text = noteData.noteTitle!;
          _contentController.text = noteData.noteContent!;
        } else {
          return setState(() {
            _isLoading = false;
            error = true;
            errorMessage = 'An error occured';
          });
        }
      });
    } else {
      return setState(() {
        _isLoading = false;
        error = true;
        errorMessage = 'An error occured';
      });
    }
  }

  @override
  void initState() {
    developer.log('noteID', error: {widget.noteID});
    _getSingleNote();

    super.initState();

    // setState(() {
    //   _isLoading = true;
    // });
    // notesService.apiGetSingleNote(widget.noteID).then(
    //   (response) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     if (response.error!) {
    //       setState(() {
    //         _isLoading = false;
    //       });
    //       errorMessage = response.errorMessage ?? 'An error occurred';
    //     }
    //     note = response.data!;
    //     _titleController.text = note.noteTitle!;
    //     _contentController.text = note.noteContent!;
    //   },
    // );
  }

  // Create Note
  // void createNote(NoteManipulation item) {
  //   var url = Uri.parse('$APIURL/notes');
  //   var response =
  //       http.post(url, headers: headers, body: json.encode(item.toJson()));
  // }

  void addNote() async {
    if (_titleController.text == '' || _contentController.text == '') {
      late String aTitle = 'Alert';
      late String aContent = 'Please fill all the fields';
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(aTitle),
                content: Text(aContent),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  )
                ],
              ));
    } else {
      setState(() {
        _isLoading = true;
      });
      final note = NoteManipulation(
          noteTitle: _titleController.text,
          noteContent: _contentController.text);
      final result = await notesService.createNote(note);

      setState(() {
        _isLoading = false;
      });

      developer.log('result->', error: {result.createdNote.toString()});

      const title = 'Done';
      final text = result.error == true
          ? (result.errorMessage ?? 'An error occurred')
          : '${result.createdNote} has been created';

      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text(title),
                content: Text(text),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      if (result.error == true) {
                        Navigator.pop(context, false);
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              )).then((data) {
        if (result.error == true) {
          Navigator.pop(context, false);
        } else {
          Navigator.of(context).pop();
        }
      });
    }
  }

  void editNote() async {
    if (_titleController.text == '' || _contentController.text == '') {
      late String aTitle = 'Alert';
      late String aContent = 'Please fill all the fields';
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(aTitle),
                content: Text(aContent),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  )
                ],
              ));
    } else {
      setState(() {
        _isLoading = true;
      });
      final eNote = NoteManipulation(
          noteTitle: _titleController.text,
          noteContent: _contentController.text);
      final result = await notesService.updateNote(mainNoteId, eNote);

      setState(() {
        _isLoading = false;
      });

      const title = 'Done';
      const text = 'Note has been updated';

      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text(title),
                content: Text(text),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      if (result.error == true) {
                        Navigator.pop(context, false);
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              )).then((data) {
        if (result.error == true) {
          Navigator.pop(context, false);
        } else {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  clearText() {
    _titleController.clear();
    _contentController.clear();
  }

  // Text Field Validation
  // String? get _errorText {
  //   final text = _titleController.text;
  //   if (text.isEmpty) {
  //     return 'Can\'t be empty';
  //   }
  //   if (text.length < 4) {
  //     return 'Too short';
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEditing ? 'Edit Note' : 'Create Note'),
        // title: Text(noteID == '' ? 'Create Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.note),
                      // hintText: 'Note Title',
                      labelText: 'Note Title',
                      // errorText: texterror ? "Enter Correct Name" : null,
                      // errorText: _errorText,
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    height: 8,
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.content_copy),
                      // hintText: 'Note Content',
                      labelText: 'Note Content',
                    ),
                  ),

                  Container(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isEditing) {
                          // Edit Ops
                          editNote();
                          // Navigator.of(context).pop();
                        } else {
                          // Add Ops
                          addNote();
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
                      onPressed: () => {clearText()},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
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
