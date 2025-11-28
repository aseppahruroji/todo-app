import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/todo_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoService = TodoService();
  final auth = AuthService();
  List<String> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Future loadTodos() async {
    todos = await todoService.getTodos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo List"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await auth.logout();
              Navigator.pushReplacementNamed(context, "/login");
            },
          )
        ],
      ),
      body: todos.isEmpty
          ? Center(child: Text("Belum ada todo"))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(todos[i]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editDialog(i);
                        },
                      ),
                      // Delete
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await todoService.deleteTodo(i);
                          loadTodos();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void addDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Tambah Todo"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () async {
              await todoService.addTodo(controller.text);
              Navigator.pop(context);
              loadTodos();
            },
            child: Text("Tambah"),
          )
        ],
      ),
    );
  }

  void editDialog(int index) {
    final controller = TextEditingController(text: todos[index]);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Todo"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () async {
              await todoService.updateTodo(index, controller.text);
              Navigator.pop(context);
              loadTodos();
            },
            child: Text("Simpan"),
          )
        ],
      ),
    );
  }
}
