import 'package:flutter/material.dart';
import 'package:flutter_playground/bloc_provider_get_controller/todo_bloc.dart';
import 'package:flutter_playground/main.dart';
import 'package:flutter_playground/models/todo_model.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class SqfLiteTodoApp extends StatefulWidget {
  @override
  _SqfLiteTodoAppState createState() => _SqfLiteTodoAppState();
}

class _SqfLiteTodoAppState extends State<SqfLiteTodoApp> {
  TodoBloc todoBloc = getIt<TodoBloc>();
  @override
  void initState() {
    todoBloc.getAllTodos();
    super.initState();
  }

  @override
  void dispose() {
    todoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQFLite Todo App"),
        actions: <Widget>[
          SmallIconButton(
            icon: Icon(Icons.delete_forever),
            onTap: () => todoBloc.deleteAll(),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamHandler<List<Todo>>(
              stream: todoBloc.stream,
              ready: (todos) {
                if (todos.isEmpty) {
                  return Center(
                    child: Text("No Todo Yet"),
                  );
                }
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Todo todo = todos[index];
                    return CheckboxListTile(
                      secondary: CircleAvatar(child: Text(todo.title[0])),
                      title: Text(todo.title),
                      onChanged: (value) {
                        Todo newTodo = todo;
                        newTodo.done = value;
                        todoBloc.updateTodo(newTodo);
                      },
                      value: todo.done,
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          AddTodoPage(),
        ],
      ),
    );
  }
}

class AddTodoPage extends StatefulWidget {
  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();
  String title;
  TodoBloc todoBloc = getIt<TodoBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Title'),
                onSaved: (value) => title = value,
                validator: (value) => value.isEmpty ? "Please add title" : null,
              ),
            ),
            JinWidget.horizontalSpace(),
            RaisedButton(
              child: Text('Add New Todo'),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  await todoBloc.addTodo(Todo(
                      title: title, id: DateTime.now().millisecondsSinceEpoch));
                  _formKey.currentState.reset();
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
