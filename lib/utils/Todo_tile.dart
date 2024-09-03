import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String taskname;
  final bool isCompleted;
  final Function(bool?)? onChanged;
  final Function()? onDelete;

  TodoTile({
    super.key,
    required this.taskname,
    required this.isCompleted,
    required this.onChanged,
    required this.onDelete,  // Added onDelete callback
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: GestureDetector(
        onLongPress: onDelete,  // Call the onDelete function when long pressed
        child: Container(
          padding: const EdgeInsets.all(23),
          child: Row(
            children: [
              // CheckBox
              Checkbox(value: isCompleted, onChanged: onChanged),
              // Task Name
              Expanded(
                child: Text(
                  taskname,
                  style: TextStyle(
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
