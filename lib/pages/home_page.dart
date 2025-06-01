import 'package:flutter/material.dart';
import 'package:simple_todo/utils/todo_list.dart';
import 'package:simple_todo/utils/notification_service.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller = TextEditingController();
  final NotificationService _notificationService = NotificationService();
  List toDoList = [
    ['Learn Flutter', false, null, null],
    ['Drink Coffee', false, null, DateTime.now().add(Duration(days: 2))],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      toDoList.add([_controller.text.trim(), false, null, null]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      if (toDoList[index][2] != null) {
        _notificationService.cancelNotification(index);
      }
      toDoList.removeAt(index);
    });
  }

  Future<void> _showAddTaskDialog() async {
    _controller.clear(); // Clear controller before showing dialog
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter task name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onSubmitted: (_) => saveNewTask(), // Allow saving with Enter key
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: saveNewTask,
            ),
          ],
        );
      },
    );
  }


  Future<void> _showEditTaskDialog(int index) async {
    final TextEditingController editController = TextEditingController(text: toDoList[index][0]);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter new task name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onSubmitted: (_) { // Allow saving with Enter key
              if (editController.text.trim().isNotEmpty) {
                _editTask(index, editController.text.trim());
              }
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                if (editController.text.trim().isNotEmpty) {
                  _editTask(index, editController.text.trim());
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editTask(int index, String newName) {
    setState(() {
      toDoList[index][0] = newName;
      // If a reminder is set, update its title
      if (toDoList[index][2] != null) {
        _notificationService.scheduleNotification(index, toDoList[index][2], newName);
      }
    });
  }

  Future<void> setReminder(int index) async {
    DateTime? selectedDateTime = await showDatePicker(
      context: context,
      initialDate: toDoList[index][2] ?? toDoList[index][3] ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      // Optional: Theme the DatePicker to match
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) async {
      if (pickedDate == null) return null;
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: toDoList[index][2] != null
            ? TimeOfDay.fromDateTime(toDoList[index][2])
            : TimeOfDay.now(),
        // Optional: Theme the TimePicker to match
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      return pickedTime == null
          ? null
          : DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
    });

    if (selectedDateTime != null) {
      setState(() {
        toDoList[index][2] = selectedDateTime;
      });
      _notificationService.scheduleNotification(index, selectedDateTime, toDoList[index][0]);
    }
  }

  Future<void> setDueDate(int index) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: toDoList[index][3] ?? DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)), // Allow past due dates for flexibility
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        // Keep time part if already set, otherwise just date
        DateTime currentDueDate = toDoList[index][3] ?? selectedDate;
        toDoList[index][3] = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, currentDueDate.hour, currentDueDate.minute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
            'Simple Todo',
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // Optional: Add a global sort/filter button here later
        ],
      ),
      body: toDoList.isEmpty
          ? Center(
          child: Text(
            "No tasks yet. Add one below!",
            style: TextStyle(color: Colors.grey[600], fontSize: 18),
          ))
      : ListView.builder(itemCount: toDoList.length, itemBuilder: (BuildContext context, index) {
        return TodoList(
          taskName: toDoList[index][0],
          taskCompleted: toDoList[index][1],
          reminderTime: toDoList[index][2],
          dueDate: toDoList[index][3],
          onChanged: (value) => checkBoxChanged(index),
          deleteFunction: (contex) => deleteTask(index),
          setReminderFunction: () => setReminder(index),
          editFunction: () => _showEditTaskDialog(index),
          setDueDateFunction: () => setDueDate(index),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Changed to show a dialog
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Center FAB
    );
  }
}