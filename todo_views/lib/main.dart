import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/theme/theme.dart';
import 'src/theme/theme_cubit.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ThemeCubit(),
    child: const App(),
  ));
}

/* App with theme controll */
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    BlocProvider.of<ThemeCubit>(context).close();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    /* Update the theme when system theme changes */
    BlocProvider.of<ThemeCubit>(context).updateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const TodoApp(),
      );
    });
  }
}
