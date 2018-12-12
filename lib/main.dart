// Import MaterialApp and other widgets which we can use to quickly create a material app
import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'Todo List', home: new TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      return _todoItems.removeAt(index);
    });
  }

  void _promRemoveItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              title:
                  new Text('Tandai "${_todoItems[index]}" sebagai selesai ?'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Batal'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                new FlatButton(
                  child: new Text('Tandai Sebagai Selesai'),
                  onPressed: () {
                    _removeTodoItem(index);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _promRemoveItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo App'),
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Add new task'),
        ),
        body: new TextField(
          autofocus: true,
          onSubmitted: (val) {
            _addTodoItem(val);
            Navigator.pop(context);
          },
          decoration: new InputDecoration(
              hintText: 'Enter something to do ...',
              contentPadding: const EdgeInsets.all(16.0)),
        ),
      );
    }));
  }
}
