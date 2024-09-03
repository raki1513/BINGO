import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  final TextEditingController Controller;
  final VoidCallback OnSave;
  final VoidCallback OnCancel;

  MyDialog({
    super.key,
    required this.Controller,
    required this.OnSave,
    required this.OnCancel,
  });

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 200,

        child: Column(
          children: [
            // Getting Input
            Container(
              child: TextField(
                controller: widget.Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add Your Task",
                ),
                maxLines: null, // Allows multiline input
                keyboardType: TextInputType.multiline, 
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: widget.OnSave,
                      child: Text("Submit"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                        minimumSize: const Size(120, 40),
                      ),
                    ),
                    SizedBox(width: 20), // Add space between the buttons
                    ElevatedButton(
                      onPressed: widget.OnCancel,
                      child: Text("Cancel"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                        minimumSize: const Size(120, 40),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
