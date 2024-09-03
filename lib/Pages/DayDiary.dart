import 'package:flutter/material.dart';

class DayDiary extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DayDiary({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Diary Entry'),
        backgroundColor: Colors.blue[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add Your Title",
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add Your Description of the Day",
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: onSave,
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200],
                      minimumSize: const Size(120, 40),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onCancel,
                    child: Text("Cancel"),
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
