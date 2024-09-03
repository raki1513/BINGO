import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/Pages/DayDiary.dart';
import 'package:myapp/Pages/Diary_Details.dart';
import 'package:myapp/utils/Diary_tile.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late Box diaryBox; // Use late to initialize it later
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    diaryBox = Hive.box('diaryBox'); // Initialize in initState
  }

  Future<void> saveTask() async{
    setState(() {
      diaryBox.add([_titleController.text, _descriptionController.text]);
    });
    Navigator.of(context).pop();
    _titleController.clear();
    _descriptionController.clear();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DayDiary(
          titleController: _titleController,
          descriptionController: _descriptionController,
          onSave: saveTask,
          onCancel: () {
            _titleController.clear();
            _descriptionController.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void navigateToDetailsScreen(String title, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiaryDetailsScreen(
          title: title,
          description: description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: diaryBox.listenable(),
        builder: (context, box, widget) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final entry = box.getAt(index) as List<String>;
              return DiaryTile(
                title: entry[0],
                description: entry[1],
                onTap: () => navigateToDetailsScreen(entry[0], entry[1]),
              );
            },
          );
        },
      ),
    );
  }
}
