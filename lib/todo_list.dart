import 'package:flutter/material.dart';
import 'package:todo_list/todo.dart';

typedef ToggleTodoCallback = void Function(Todo todo, bool isChecked);

class TodoList extends StatelessWidget {
  const TodoList({required this.todos, this.onTodoToggle, super.key});

  final List<Todo> todos;
  final ToggleTodoCallback? onTodoToggle;

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];

    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool? isChecked) {
        if (isChecked != null && onTodoToggle != null) {
          onTodoToggle!(todo, isChecked);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: todos.length,
    );
  }
}
