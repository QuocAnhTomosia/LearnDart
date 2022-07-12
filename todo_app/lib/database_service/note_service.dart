import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/note.dart';


// tao ra mot class Database Helper theo
// singleton de dam bao toc do truy van
// va chi co mot instance duoc phep truy 
//cap vao database
class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

 
// create
  Future _onCreate(Database db, int version) async {
    await db.execute(
      ''' 
CREATE TABLE notes(
      id INTEGER PRIMARY KEY,
      title TEXT,
      details TEXT,
      start TEXT,
      end TEXT
    )
    ''');
  }

  //read

  Future<List<Note>> getNotes() async {
    Database db = await instance.database;
    var notes = await db.query('notes', orderBy: 'title');
    List<Note> notesList =
        notes.isNotEmpty ? notes.map((c) => Note.fromMap(c)).toList() : [];
    return notesList;
  }

  Future<int> add(Note note) async {
    Database db = await instance.database;
    return await db.insert('notes', note.toMap());
  }

//update
  Future<int> update(Note note) async {
    Database db = await instance.database;
    return await db
        .update('notes', note.toMap(), where: "id = ?", whereArgs: [note.id]);
  }

//delete
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
