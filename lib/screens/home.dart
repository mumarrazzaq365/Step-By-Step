// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import 'package:provider/provider.dart';
import 'package:stepbystep/colors.dart';

import 'package:stepbystep/providers/taskCollection.dart';

import 'package:stepbystep/screens/self_task_manager/update_task.dart';

import 'package:stepbystep/sql_database/sql_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  IconData taskStatusIcon = Icons.check_box_outline_blank_rounded;
  String dateFilter = '';

  @override
  void initState() {
    context.read<TaskCollection>().refreshData();

    super.initState();
  }

  void _deleteTask(int id) async {
    await SQLHelper.deleteTask(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Task Deleted Successfully'),
    ));
    context.read<TaskCollection>().refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FlutterDatePickerTimeline(
              initialSelectedDate: DateTime.now(),
              startDate: DateTime.now(),
              endDate: DateTime(3000, 01, 30),
              calendarMode: CalendarMode.gregorian,
              onSelectedDateChange: (DateTime? dateTime) {
                dateFilter = formatDate(dateTime!, [yyyy, '-', mm, '-', dd]);
              },
            ),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Color(0xffF3520C),
                      ),
                    )
                  : context.watch<TaskCollection>().getTask.isEmpty
                      ? const Center(child: Text('No TASK'),)
                      : ListView.builder(
                          itemCount:
                              context.watch<TaskCollection>().getTask.length,
                          itemBuilder: (context, index) {
                            final task = Provider.of<TaskCollection>(context,
                                    listen: false)
                                .getTask[index];

                            return SwipeActionCell(
                              key: ObjectKey(task['id']),
                              trailingActions: [
                                SwipeAction(
                                  title: "Delete",
                                  style: TextStyle(
                                      fontSize: 12, color: AppColor.white),
                                  color: Colors.red,
                                  icon:
                                      Icon(Icons.delete, color: AppColor.white),
                                  onTap: (CompletionHandler handler) async {
                                    openDeleteDialog(task['id']);
                                    setState(() {});
                                  },
                                ),
                              ],
                              child: TaskTile(
                                task: task,
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  openDeleteDialog(int id) => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            var width = MediaQuery.of(context).size.width;
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              title: const Center(child: Text('Delete Task')),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: width,
                  height: 40.0,
                  child: Center(
                      child: Column(
                    children: const [
                      Text('Do you want to delete task'),
                      Text('Deleted task cannot be recovered',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                              color: Colors.red)),
                    ],
                  )),
                ),
              ),
              actions: [
                //CANCEL Button
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                //CREATE Button
                TextButton(
                  onPressed: () async {
                    _deleteTask(id);
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  child: const Text(
                    'DELETE',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ),
      );
}

class TaskTile extends StatelessWidget {
  final task;
  const TaskTile({Key? key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateTask(
              id: task['id'],
              title: task['taskTitle'],
              description: task['taskDescription'],
              taskStatus: task['taskStatus'],
            ),
          ),
        );
      },
      leading: IconButton(
        onPressed: () {
          String taskStatus = task['taskStatus'];

          if (taskStatus == 'TODO') {
            taskStatus = 'COMPLETED';
          } else {
            taskStatus = 'TODO';
          }
          _updateTaskStatus(
              id: task['id'],
              title: task['taskTitle'],
              description: task['taskDescription'],
              taskDate: task['taskDate'],
              taskTime: task['taskTime'],
              dateFilter: task['dateFilter'],
              notification: task['notification'],
              taskStatus: taskStatus,
              context: context);
        },
        splashRadius: 25,
        color: task['taskStatus'] == 'TODO' ? AppColor.black : AppColor.grey,
        icon: Icon(task['taskStatus'] == 'TODO'
            ? Icons.check_box_outline_blank_rounded
            : Icons.check_box_outlined),
      ),
      title: Text(
        task['taskTitle'],
        style: TextStyle(
            color:
                task['taskStatus'] == 'TODO' ? AppColor.black : AppColor.grey,
            decoration: task['taskStatus'] == 'TODO'
                ? TextDecoration.none
                : TextDecoration.lineThrough),
      ),
      subtitle: Text(
        task['dateFilter'], //taskDescription
        style: TextStyle(
            decoration: task['taskStatus'] == 'TODO'
                ? TextDecoration.none
                : TextDecoration.lineThrough),
      ),
    );
  }

  Future<void> _updateTaskStatus(
      {required int id,
      required String title,
      required String description,
      required String taskDate,
      required String taskTime,
      required String dateFilter,
      required String notification,
      required String taskStatus,
      required BuildContext context}) async {
    await SQLHelper.updateTask(
      id: id,
      title: title,
      description: description,
      taskDate: taskDate,
      taskTime: taskTime,
      dateFilter: dateFilter,
      notification: notification,
      taskStatus: taskStatus,
    );
    context.read<TaskCollection>().refreshData();
  }
}
