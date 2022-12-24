import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/bloc/todo/todo_list_bloc.dart';
import 'package:todo_model/todo_model.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late TodoListBloc _bloc;

  @override
  void initState() {
    _bloc = TodoListBloc();
    super.initState();
    _bloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildTodoList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text("Todo List",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold));
  }

  Widget _buildTodoList() {
    return BlocBuilder<TodoListBloc, CubitState<TodoListState>>(
      bloc: _bloc,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CupertinoActivityIndicator(radius: 17));
        }
        if (state.current.todoList.isEmpty) {
          return const Center(child: Text("Empty Todo List"));
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children:
                state.current.todoList.map((e) => _buildTodoTile(e)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildTodoTile(Todo todo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 10,
            color: todo.isCompleted ? Colors.green : Colors.red,
          ),
          ListTile(
            title: Text(
              todo.todo,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(todo.desc),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check_circle_rounded,
                      color: Colors.green),
                  onPressed: () => _bloc.markComplete(todo.id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever_rounded,
                      color: Colors.red),
                  onPressed: () => _bloc.deleteTodo(todo.id),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
