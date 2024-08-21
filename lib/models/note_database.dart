import 'package:isar/isar.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase {
  // Initialize Database
  static late Isar isar;
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // list of notes
  List<Note> currentNotes = [];

  // create
  Future<void> addNote(String note) async {
    // initialize new note object
    final newNote = Note()..note = note;

    // save to db
    await isar.writeTxn(() => isar.notes.put(newNote));

    // re read from db
    await fetchNotes();
  }

  // read
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
  }

  // update
  Future<void> updateNote(int id, String newNote) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.note = newNote;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
