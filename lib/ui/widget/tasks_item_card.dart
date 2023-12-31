import 'package:flutter/material.dart';
import 'package:module12/data.network_caller/network_caller.dart';

import '../../data.network_caller/Utility/urls.dart';
import '../../data.network_caller/models/task.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  calcelled,
}

class TasksItemCard extends StatefulWidget {
  const TasksItemCard({
    super.key,
    required this.task,
    required this.onStatusChange,
    required this.showProgress,
    this.onStatusSummaryCardChange,
    this.showProgressForSummaryCard,
  });
  final Task task;
  final VoidCallback onStatusChange;
  final VoidCallback? onStatusSummaryCardChange;
  final Function(bool) showProgress;
  final Function(bool)? showProgressForSummaryCard;

  @override
  State<TasksItemCard> createState() => _TasksItemCardState();
}

class _TasksItemCardState extends State<TasksItemCard> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    widget.showProgressForSummaryCard!(true);
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(widget.task.sId ?? '', status));
    if (response.isSuccess) {
      widget.onStatusChange();
      widget.onStatusSummaryCardChange!();
    }
    widget.showProgress(false);
    widget.showProgressForSummaryCard!(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(widget.task.description ?? ''),
            Text('date:${widget.task.createdDate}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_forever),
                    ),
                    IconButton(
                      onPressed: () {
                        showUpdateStatusModel();
                      },
                      icon: const Icon(Icons.edit),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModel() {
    List<ListTile> item = TaskStatus.values
        .map((e) => ListTile(
              title: Text(e.name),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: item,
          ),
          actions: [
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
