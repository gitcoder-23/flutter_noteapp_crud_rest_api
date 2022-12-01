import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note_insert.g.dart';

@JsonSerializable()
class NoteManipulation {
  String? noteTitle;
  String? noteContent;

  NoteManipulation({
    @required this.noteTitle,
    @required this.noteContent,
  });

  Map<String, dynamic> toJson() {
    return {
      'noteTitle': noteTitle,
      'noteContent': noteContent,
    };
  }

  // Map<String, dynamic> toJson() => _$NoteManipulationToJson(this);
}

class InsertNote {
  String? noteID;
  String? noteTitle;
  String? noteContent;
  DateTime? createDateTime;
  DateTime? latestEditDateTime;

// constructor
  InsertNote({
    this.noteID,
    this.noteTitle,
    this.noteContent,
    this.createDateTime,
    this.latestEditDateTime,
  });
}
