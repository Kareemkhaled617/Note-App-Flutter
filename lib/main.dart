import 'package:flutter/material.dart';
import 'package:note_project/screens/First.dart';
import 'package:note_project/screens/note_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/note_provider.dart';
import 'screens/note_edit_screen.dart';
import 'screens/note_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool val = false;

  Future get_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      val = prefs.getBool('status') ?? false;
    });
    return prefs.getBool('status');
  }

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    shadowColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
  );

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blueAccent,
    shadowColor: Colors.white,
  );

  @override
  void initState() {
      get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NoteProvider(),
      child: MaterialApp(
        theme: val? _darkTheme : _lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => FirstScreen(),
          NoteListScreen.route: (context) => NoteListScreen(),
          NoteViewScreen.route: (context) => NoteViewScreen(),
          NoteEditScreen.route: (context) => NoteEditScreen(),
        },
      ),
    );
  }
}
