import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/Pages/Home_Screen.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final TextEditingController nameController = TextEditingController();

  Future<void> login() async {
    final username = nameController.text;
    var box = Hive.box('userBox');
    await box.put('username', username);
    if (username.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(username: username),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to BINGO! An All-New Productivity Tool'),
        backgroundColor: Colors.blue[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter Your Name "),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your Username",
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: login,
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200],
                      minimumSize: const Size(120, 40),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
