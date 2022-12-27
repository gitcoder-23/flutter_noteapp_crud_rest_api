import 'package:flutter/material.dart';
import 'package:flutter_crud_rest_api/services/notes_service.dart';
import 'package:flutter_crud_rest_api/views/quill_example.dart';
import 'package:get_it/get_it.dart';

void setupServiceDiLocator() {
  GetIt.instance.registerLazySingleton(
    () => NotesService(),
  );

  // GetIt.I.registerLazySingleton(
  //   () => NotesService(),
  // );

  // getIt.registerSingleton<NoteListModel>(NoteListModel());
}

void main() {
  setupServiceDiLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Crud Using Api Note App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuillExample(title: 'Note List'),
    );
  }
}
