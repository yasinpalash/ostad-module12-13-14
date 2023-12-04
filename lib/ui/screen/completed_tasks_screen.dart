import 'package:flutter/material.dart';

import '../../data.network_caller/Utility/urls.dart';
import '../../data.network_caller/models/task_list_model.dart';
import '../../data.network_caller/network_caller.dart';
import '../../data.network_caller/network_response.dart';
import '../widget/profile_summary_card.dart';
import '../widget/tasks_item_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  bool getCompletedTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  Future<void> getProgressCompleted() async {
    getCompletedTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCompleted);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCompletedTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
  @override
  void initState() {
    super.initState();
    getProgressCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ProfileSummaryCard(),

            Expanded(
              child: Visibility(
                visible: getCompletedTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getProgressCompleted,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TasksItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: () {
                          getProgressCompleted();
                        },
                        showProgress: (inProgress) {
                          getCompletedTaskInProgress = inProgress;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
