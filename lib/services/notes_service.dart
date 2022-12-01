import 'package:flutter_crud_rest_api/models/note_insert.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:flutter_crud_rest_api/models/api_response.dart';
import 'package:flutter_crud_rest_api/models/note_for_listing.dart';

class NotesService {
  List<NoteForListing> notes = [
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
  List<NoteForListing> getNotesList() {
    return notes;
  }

  // Get Data from Api Http

  static const APIURL = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': '21d9dc11-dcd7-4dc7-b7a7-5009eb9b0e90',
    'Content-Type': 'application/json',
  };

  Future<APIResponse<List<NoteForListing>>> apiGetNotesList() {
    var url = Uri.parse('$APIURL/notes');
    return http.get(url, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
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
        return APIResponse<List<NoteForListing>>(data: notes);
      } else {
        return APIResponse<List<NoteForListing>>(
            error: true, errorMessage: 'An error occured');
      }
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: 'An error occured'));
  }

  //  Single Note

  Future<APIResponse<SingleNote>> apiGetSingleNote(String noteID) {
    var url = Uri.parse('$APIURL/notes/$noteID');

    return http.get(url, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        // developer.log('jsonData-single->', error: {data.body});
        final note = SingleNote(
          noteID: jsonData['noteID'],
          noteTitle: jsonData['noteTitle'],
          noteContent: jsonData['noteContent'],
          createDateTime: DateTime.parse(jsonData['createDateTime']),
          latestEditDateTime: jsonData['latestEditDateTime'] != null
              ? DateTime.parse(jsonData['latestEditDateTime'])
              : null,
        );
        return APIResponse<SingleNote>(data: note);
      } else {
        return APIResponse<SingleNote>(
            error: true, errorMessage: 'An error occured');
      }
    }).catchError((_) =>
        APIResponse<SingleNote>(error: true, errorMessage: 'An error occured'));
  }

  // Create Note {bool -> note creation was success or not}

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    var url = Uri.parse('$APIURL/notes');
    return http
        .post(url, headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      final jsonData = json.decode(data.body);

      final createdNote = NoteManipulate(
        noteID: jsonData['noteID'],
        noteTitle: jsonData['noteTitle'],
        noteContent: jsonData['noteContent'],
        createDateTime: DateTime.parse(jsonData['createDateTime']),
        latestEditDateTime: jsonData['latestEditDateTime'] != null
            ? DateTime.parse(jsonData['latestEditDateTime'])
            : null,
      );

      if (data.statusCode == 201) {
        return APIResponse<bool>(
            data: true, createdNote: createdNote.noteTitle);
      }

      return APIResponse<bool>(
        error: true,
        errorMessage: 'An error occured',
      );
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  // Update Note {bool -> note creation was success or not}

  Future<APIUpdateResponse<bool>> updateNote(
      String noteID, NoteManipulation item) {
    var url = Uri.parse('$APIURL/notes/$noteID');
    return http
        .put(url, headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      final jsonData = json.decode(data.body);
      print('up-jsonData->$jsonData');
      developer.log('updateNote-->', error: {jsonData});

      if (data.statusCode == 204) {
        return APIUpdateResponse<bool>(data: true);
      } else {
        return APIUpdateResponse<bool>(
          error: true,
          errorMessage: 'An error occured',
        );
      }

      // final updatedNote = NoteManipulate(
      //   noteID: jsonData['noteID'],
      //   noteTitle: jsonData['noteTitle'],
      //   noteContent: jsonData['noteContent'],
      //   createDateTime: DateTime.parse(jsonData['createDateTime']),
      //   latestEditDateTime: jsonData['latestEditDateTime'] != null
      //       ? DateTime.parse(jsonData['latestEditDateTime'])
      //       : null,
      // );

      // if (data.statusCode == 204) {
      //   return APIUpdateResponse<bool>(
      //       data: true, updatedNote: updatedNote.noteTitle);
      // }
    }).catchError((_) => APIUpdateResponse<bool>(
            error: true, errorMessage: 'An error occured'));
  }

  // Delete Notes
  Future<APIResponse<bool>> deleteNote(String noteID) {
    var url = Uri.parse('$APIURL/notes/$noteID');
    return http.delete(url, headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  //   List<NoteForListing> getNotesList() {
  //   return [
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
  // }
}
