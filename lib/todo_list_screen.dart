import 'package:flutter/material.dart';
import 'package:todo_list/todo.dart';
import 'package:todo_list/todo_repository.dart';
import 'package:todo_list/new_todo_dialog.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final loadedTodos = await TodoRepository.loadTodos();
    setState(() {
      todos = loadedTodos;
    });
  }

  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
    TodoRepository.saveTodos(todos);
  }

  _addTodo() async {
    final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return NewTodoDialog();
      },
    );

    if (todo != null) {
      setState(() {
        todos.add(todo);
      });
      TodoRepository.saveTodos(todos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return CheckboxListTile(
            value: todo.isDone,
            title: Text(todo.title),
            onChanged: (bool? isChecked) {
              if (isChecked != null) {
                _toggleTodo(todo, isChecked);
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}
