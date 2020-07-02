import 'package:flutter_playground/main.dart';
import 'package:flutter_playground/models/todo_model.dart';
import 'package:flutter_playground/bloc_provider_get_controller/todo_db_provider.dart';
import 'package:rxdart/rxdart.dart';

class TodoBloc {
  List<Todo> _todos;
  TodoDBProvider todoProvider = getIt<TodoDBProvider>();
  BehaviorSubject<List<Todo>> _subject = BehaviorSubject();

  //
  List<Todo> get getTodo => _todos;
  Stream get stream => _subject.stream;

  void getAllTodos() async {
    try {
      _todos = await todoProvider.getAllTodo();
      _subject.add(_todos);
    } catch (e) {
      _subject.addError(e.toString());
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      await todoProvider.insert(todo);
      var newTodos = [..._todos];
      newTodos.add(todo);
      _todos = newTodos;
      _subject.add(_todos);
    } catch (e) {
      _subject.addError(e.toString());
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await todoProvider.update(todo);
      var newTodos = [..._todos];
      newTodos.firstWhere((td) => td.id == todo.id).done = todo.done;
      _todos = newTodos;
      _subject.add(_todos);
    } catch (e) {
      _subject.addError(e.toString());
    }
  }

  Future<void> deleteAll() async {
    try {
      await todoProvider.deleteAll();
      _todos.clear();
      _subject.add(_todos);
    } catch (e) {
      _subject.addError(e.toString());
    }
  }

  void dispose() async {
    _subject.drain().then((v) {
      print("Drain success");
    }).catchError((err) {
      print("Drain error: ${err.toString()}");
    });
    //_subject.close();
  }
}
