import 'package:base/base.dart';
import 'package:dio/dio.dart';
import 'package:todo/src/app_context.dart';
import 'package:todo_businesslogic/todo_businesslogic.dart';

import "http_utilities.dart";

class AppInitState {
  AppInitState();
}

class AppInitBloc extends CubitBase<AppInitState> {
  AppInitBloc() : super(CubitState<AppInitState>(AppInitState()));

  static const baseURL = "http://localhost:3000";

  Dio getHttpClient() {
    //This requires a TOKEN to be passed
    //Inject the token in headers through interceptors

    const int STATUS_CODE_SUCCESS = 200;

    var options = BaseOptions(baseUrl: baseURL);
    var client = Dio(options);
    client.addStatusCodeValidator(STATUS_CODE_SUCCESS);

    return client;
  }

  initializeServices() async {
    AppContext.locator.registerFactory<ITodoService>(
        () => TodoService(client: getHttpClient()));
  }

  Future<void> initialize() async {
    await initializeServices();
    emitLoadedState();
  }
}
