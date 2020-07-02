import 'package:flutter_playground/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';

class TodoDBProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path,
        version: 1,
        onUpgrade: _onUpgrade,
        onDowngrade: onDatabaseDowngradeDelete,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // Database is created, create the table
    await db.execute(
        'create table $tableTodo ($columnId integer primary key autoincrement, $columnTitle text not null,$columnDone integer not null)');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Database version is updated, alter the table
    await db.execute("ALTER TABLE Test ADD name TEXT");
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<List<Todo>> getAllTodo() async {
    List<Map> maps =
        await db.query(tableTodo, columns: [columnId, columnDone, columnTitle]);
    if (maps.length > 0) {
      return maps.map((map) {
        return Todo.fromMap(map);
      }).toList();
    }
    return [];
  }

  Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    return await db.delete(tableTodo);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}
