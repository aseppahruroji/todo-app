import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TodoService {
  Future<List<String>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("todos");
    if (data == null) return [];
    return List<String>.from(jsonDecode(data));
  }

  Future saveTodos(List<String> todos) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("todos", jsonEncode(todos));
  }

  Future addTodo(String title) async {
    final todos = await getTodos();
    todos.add(title);
    await saveTodos(todos);
  }

  Future updateTodo(int index, String newTitle) async {
    final todos = await getTodos();
    todos[index] = newTitle;
    await saveTodos(todos);
  }

  Future deleteTodo(int index) async {
    final todos = await getTodos();
    todos.removeAt(index);
    await saveTodos(todos);
  }
}
