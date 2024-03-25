import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> todos = [];
  Color? backgroundColor = Colors.lightBlue[50];

  void addTodo(String todo) {
    setState(() {
      todos.add(TodoItem(title: todo, completed: false));
      backgroundColor = Colors.lightGreenAccent[100];
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        backgroundColor = Colors.lightBlue[50];
      });
    });
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void toggleTodoCompleted(int index) {
    setState(() {
      todos[index].completed = !todos[index].completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: backgroundColor,
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: todos[index].completed ? 0.5 : 1.0,
              child: ListTile(
                title: Text(
                  todos[index].title,
                  style: TextStyle(
                    fontSize: 24.0,
                    decoration: todos[index].completed
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                leading: todos[index].completed
                    ? Icon(Icons.check_box)
                    : Icon(Icons.check_box_outline_blank),
                onTap: () => toggleTodoCompleted(index),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeTodo(index),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndDisplayAddTodoScreen(context);
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  _navigateAndDisplayAddTodoScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTodoScreen()),
    );

    if (result != null) {
      addTodo(result);
    }
  }
}

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter your task',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _textEditingController.text);
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoItem {
  String title;
  bool completed;

  TodoItem({required this.title, required this.completed});
}
