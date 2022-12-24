import 'package:get_it/get_it.dart';

class AppContext {
  static final GetIt _locator = GetIt.instance;

  static GetIt get locator => _locator;
}
