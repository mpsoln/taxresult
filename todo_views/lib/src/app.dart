import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/screens/todo/tax_page.dart';
import 'package:todo/src/screens/todo/todo_list_page.dart';

import 'bloc/app_init_bloc.dart';

class TodoApp extends StatefulWidget {
  static const routeName = "/";
  const TodoApp({Key? key}) : super(key: key);

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late AppInitBloc _bloc;

  @override
  void initState() {
    _bloc = AppInitBloc();
    super.initState();
    _bloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppInitBloc, CubitState<AppInitState>>(
      bloc: _bloc,
      listener: (context, state) async {
        if (state.isFailure) {
          this.context.showMessageBox(
              (state as CubitFailureState).failureMessage,
              "Something went wrong");
        } else if (!state.isLoading) {
          await Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const TodoListPage()));
             // context, MaterialPageRoute(builder: (_) => const Tax()));
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CupertinoActivityIndicator(radius: 14),
            ],
          ),
        ),
      ),
    );
  }
}
