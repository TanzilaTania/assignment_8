import 'package:assignment_8/task.dart';
import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController discriptionEditingController =
  TextEditingController();
  final TextEditingController dateEditingController = TextEditingController();
  List<Task> tasklist = [
    Task(
        title: 'Test',
        description:
        'Test descriptions ',
        daysReq:  '2'),
    Task(title: 'Live Test', description: 'Attend live test', daysReq: '4'),
    Task(title: 'Quiz', description: 'Attend quiz', daysReq: '4'),
    Task(title: 'Assignment', description: 'Attend Assignment',daysReq: '4'),
  ];
  void showDialogbox() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add Task'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              TextField(
                controller: titleEditingController,
                decoration: const InputDecoration(
                    hintText: 'Title', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: discriptionEditingController,
                //minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    hintText: 'Description',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: dateEditingController,
                decoration: const InputDecoration(
                    hintText: 'Days Required', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
          TextButton(
            onPressed: () => {
              addTask(),
              Navigator.pop(context),
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Task Details',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Title: ${tasklist[index].title}',
                    style: const TextStyle(fontSize: 17),
                  ),
                  Text(
                    'Description: ${tasklist[index].description}',
                    style: const TextStyle(fontSize: 17),
                  ),
                  Text(
                    'Days Required: ${tasklist[index].daysReq}',
                    style: const TextStyle(fontSize: 17),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      deleteTask(index);
                    },
                    child: const Text('Delete'),
                  )
                ],
              ),
            ),
          );
        });
  }

  void addTask() {
    setState(() {
      if (titleEditingController.text.trim().isNotEmpty &&
          discriptionEditingController.text.trim().isNotEmpty &&
          dateEditingController.text.trim().isNotEmpty) {
        tasklist.add(
          Task(
              title: titleEditingController.text,
              description: discriptionEditingController.text,
              daysReq: dateEditingController.text),
        );

        titleEditingController.clear();
        discriptionEditingController.clear();
        dateEditingController.clear();
      } else {
        return;
      }
    });
  }

  void deleteTask(int index) {
    tasklist.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasklist.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                child: ListTile(
                  onLongPress: () => _showModalBottomSheet(index),
                  title: Text(tasklist[index].title),
                  subtitle: Text(tasklist[index].description),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showDialogbox,
        child: const Icon(Icons.add),
      ),
    );
  }
}
