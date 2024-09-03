import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Add this import for Hive initialization in Flutter
import 'package:myapp/Pages/Diary_Screen.dart';
import 'package:myapp/Pages/Pomodoro_Timer.dart';
import 'package:myapp/Pages/Todos_Screen.dart';
import 'package:myapp/Pages/User.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter(); // Initialize Hive for Flutter
  await Hive.openBox('userBox');
  await Hive.openBox('todoBox'); // Open the box for todos
  await Hive.openBox('diaryBox'); // Open the box for diary entries

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: User(),
      routes: {
        '/Todo': (context) => TodosScreen(),
        '/Diary': (context) => DiaryScreen(),
        '/Timer': (context) => PomodoroTimer(),
      },
    );
  }
}
