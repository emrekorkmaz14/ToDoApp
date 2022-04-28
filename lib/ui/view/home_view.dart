import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/model/todo_model.dart';
import 'package:todoapp/ui/shared/styles/text_style.dart';
import 'package:todoapp/ui/shared/widgets/add_todo.dart';
import 'package:todoapp/ui/shared/widgets/todo_list.dart';
import 'package:todoapp/ui/view/sign_in_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Todo> todos = [];
  _addTodo() async {
    final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return AddToDo();
      },
    );

    if (todo != null) {
      setState(() {
        todos.add(todo);
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignInView()));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
        title: Text(
          "ToDo",
          style: black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.03,
            horizontal: MediaQuery.of(context).size.height * 0.025),
        child: TodoList(todos: todos),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          setState(() {
            _addTodo();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
