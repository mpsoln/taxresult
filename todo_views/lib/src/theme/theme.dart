import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

/*-----------------------------------------------------------------*/
/*)))))))))))))>> Theme <<(((((((((((((*/
/*-----------------------------------------------------------------*/

class AppTheme {
  static Color lightBackgroundColor = const Color(0xFFF2F0E4);
  static Color darkBackgroundColor = const Color(0xff38383d);

  const AppTheme._();

/*>>>>>>>>>>>>>>>>>>>>>>>>> LIGHT THEME <<<<<<<<<<<<<<<<<<<<<<<<<*/

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    // backgroundColor: Colors.white,
    primarySwatch: Colors.indigo,
    primaryColor: const Color(0xFF335797),
    // scaffoldBackgroundColor: Colors.white,

    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 5,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF5874A4)),
    bottomAppBarColor: Colors.white,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
    ),
    tabBarTheme: const TabBarTheme(labelColor: Colors.black),
    inputDecorationTheme:
        const InputDecorationTheme(labelStyle: TextStyle(color: Colors.black)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

/*>>>>>>>>>>>>>>>>>>>>>>>>> DARK THEME <<<<<<<<<<<<<<<<<<<<<<<<<*/

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    // backgroundColor: const Color(0xff38383d),
    // scaffoldBackgroundColor: const Color(0xff38383d),
    primarySwatch: Colors.indigo,
    primaryColor: const Color(0xFF335797),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      // backgroundColor: Color(0xff38383d),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    bottomAppBarColor: const Color(0xff363636),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.black54,
    ),
    inputDecorationTheme:
        const InputDecorationTheme(labelStyle: TextStyle(color: Colors.black)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

/* ------------------  ------------------ */
  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

/* ------------------  ------------------ */
  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? lightBackgroundColor
          : darkBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}

/* ------------------  ------------------ */
extension ThemeExtras on ThemeData {
  LinearGradient get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF31568E), Color(0xFF91ACDA)],
        stops: [0, 1],
        begin: AlignmentDirectional(0, -1),
        end: AlignmentDirectional(0, 1),
      );
}
