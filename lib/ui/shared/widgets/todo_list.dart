import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/core/model/todo_model.dart';

typedef ToggleTodoCallback = void Function(Todo, bool);

class TodoList extends StatefulWidget {
  const TodoList({
    required this.todos,
  });

  final List<Todo> todos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Widget _buildItem(BuildContext context, int index) {
    final todo = widget.todos[index];

    return ListTile(
      title: Text(todo.title),
      subtitle: Text(DateFormat.yMMMd().format(DateTime.now())),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            widget.todos.remove(todo);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: widget.todos.length,
    );
  }
}
