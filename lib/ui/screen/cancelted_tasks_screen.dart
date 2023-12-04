import 'package:flutter/material.dart';

import '../../data.network_caller/Utility/urls.dart';
import '../../data.network_caller/models/task_list_model.dart';
import '../../data.network_caller/network_caller.dart';
import '../../data.network_caller/network_response.dart';
import '../widget/profile_summary_card.dart';
import '../widget/tasks_item_card.dart';

class CanceledTasksScreen extends StatefulWidget {
  const CanceledTasksScreen({super.key});

  @override
  State<CanceledTasksScreen> createState() => _CanceltedTasksScreenState();
}

class _CanceltedTasksScreenState extends State<CanceledTasksScreen> {
  bool getCancelledTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  Future<void> getProgressCancelled() async {
    getCancelledTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCancelled);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCancelledTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
  @override
  void initState() {
    super.initState();
    getProgressCancelled();
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
                visible: getCancelledTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getProgressCancelled,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TasksItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: () {
                          getProgressCancelled();
                        },
                        showProgress: (inProgress) {
                          getCancelledTaskInProgress = inProgress;
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
