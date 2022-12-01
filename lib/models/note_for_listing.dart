// List Of Notes

class NoteForListing {
  String? noteID;
  String? noteTitle;
  DateTime? createDateTime;
  // dynamic latestEditDateTime;
  DateTime? latestEditDateTime;

// constructor
  NoteForListing({
    // required this.noteId,
    this.noteID,
    this.noteTitle,
    this.createDateTime,
    this.latestEditDateTime,
  });
}

// Single note
class SingleNote {
  String? noteID;
  String? noteTitle;
  String? noteContent;
  DateTime? createDateTime;
  DateTime? latestEditDateTime;

// constructor
  SingleNote({
    this.noteID,
    this.noteTitle,
    this.noteContent,
    this.createDateTime,
    this.latestEditDateTime,
  });
}

// Create Note
// class NoteInsert {
//   String noteTitle;
//   String noteContent;

// // constructor
//   NoteInsert({
//     required this.noteTitle,
//     required this.noteContent,
//   });
// }
