import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/utils/NewTask.dart';
import 'package:myapp/utils/Todo_tile.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final TextEditingController _controller = TextEditingController();
  final Box todoBox = Hive.box('todoBox'); // Access the Hive box

  void saveTask() {
    setState(() {
      todoBox.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    _controller.clear();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
          Controller: _controller,
          OnSave: saveTask,
          OnCancel: () {
            Navigator.of(context).pop();
            _controller.clear();
          },
        );
      },
    );
  }

  Future<void> deleteTask(int index) async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      todoBox.deleteAt(index); // Use deleteAt for Hive box
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: Icon(Icons.add),
        
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, box, widget) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final task = box.getAt(index) as List<dynamic>;
              return TodoTile(
                taskname: task[0] as String,
                isCompleted: task[1] as bool,
                onChanged: (value) {
                  setState(() {
                    task[1] = value!;
                    box.putAt(index, task);
                  });
                  if(task[1]= true){
                    deleteTask(index);
                  }
                },
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete Task"),
                        content: Text("Are you sure you want to delete this task?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              deleteTask(index);
                              Navigator.of(context).pop();
                            },
                            child: Text("Delete"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
