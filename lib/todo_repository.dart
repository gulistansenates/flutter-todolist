import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo.dart';

class TodoRepository {
  static Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? todosString = prefs.getStringList('todos');

    if (todosString == null) {
      return [];
    }
    return todosString.map((todoStr) {
      final Map<String, dynamic> todoMap =
          Map<String, dynamic>.from(jsonDecode(todoStr));
      return Todo.fromMap(todoMap);
    }).toList();
  }

  static Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosString = todos.map((todo) => jsonEncode(todo.toMap())).toList();
    await prefs.setStringList('todos', todosString);
  }
}
