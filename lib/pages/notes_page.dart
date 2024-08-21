import 'package:flutter/material.dart';
import 'package:notes/models/note_database.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    readNote();
    super.initState();
  }

  final textController = TextEditingController();

  // create note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  color: Colors.grey.shade900,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                MaterialButton(
                  color: Colors.grey.shade900,
                  onPressed: () {
                    context.read<NoteDatabase>().addNote(textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'save',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ));
  }

  // read note
  void readNote() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update note
  void updateNote(Note note) {
    // prefill the text
    textController.text = note.note;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            color: Colors.grey.shade900,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          MaterialButton(
            color: Colors.grey.shade900,
            onPressed: () {
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'update',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // delete note
  void deleteNote(Note note) {
    context.read<NoteDatabase>().deleteNote(note.id);
  }

  @override
  Widget build(BuildContext context) {
    // access database
    final noteDatabase = context.watch<NoteDatabase>();

    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'N O T E S',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        shape: const CircleBorder(eccentricity: 1),
        onPressed: () => createNote(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(currentNotes[index].note),
          );
        },
      ),
    );
  }
}
