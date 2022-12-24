import 'package:base/base.dart';
import 'package:todo/src/app_context.dart';
import 'package:todo_businesslogic/todo_businesslogic.dart';
import 'package:todo_model/todo_model.dart';

class TodoListState {
  List<Todo> todoList;

  TodoListState({
    required this.todoList,
  });
}

class TodoListBloc extends CubitBase<TodoListState> {
  TodoListBloc() : super(CubitState(TodoListState(todoList: [])));

  initialize() async {
    emitLoadingState();
    await getTodoList();
    emitLoadedState();
  }

  getTodoList() async {
    state.current.todoList =
        await AppContext.locator.get<ITodoService>().getTodoList();
  }

  markComplete(int id) async {
    emitLoadingState();
    await AppContext.locator.get<ITodoService>().markComplete(id);
    await getTodoList();
    emitLoadedState();
  }

  deleteTodo(int id) async {
    emitLoadingState();
    await AppContext.locator.get<ITodoService>().delete(id);
    await getTodoList();
    emitLoadedState();
  }
}
