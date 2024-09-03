import 'package:flutter/material.dart';

class DiaryTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  DiaryTile({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
            ),
            SizedBox(height: 4),
            Text(description),
          ],
        ),
      ),
    );
  }
}
