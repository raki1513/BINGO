import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/Pages/Diary_Screen.dart';
import 'package:myapp/Pages/Pomodoro_Timer.dart';
import 'package:myapp/Pages/Todos_Screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;

  void indexChange(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  final List<Widget> _pages = [
    TodosScreen(),
    DiaryScreen(),
    PomodoroTimer(),
  ];

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('userBox');
    String username = box.get('username', defaultValue: 'User');

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "BINGO!",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      body: _pages[selectIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 166, 30, 229),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, $username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.list, size: 20),
              title: Text("To Do's"),
              onTap: () {
                indexChange(0);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.book, size: 20),
              title: Text("Your Space"),
              onTap: () {
                indexChange(1);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.timer, size: 20),
              title: Text("Pomodoro Timer"),
              onTap: () {
                indexChange(2);
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}
