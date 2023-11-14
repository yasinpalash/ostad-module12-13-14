import 'package:flutter/material.dart';

import '../widget/profile_summary_card.dart';
import '../widget/tasks_item_card.dart';

class CanceledTasksScreen extends StatefulWidget {
  const CanceledTasksScreen({super.key});

  @override
  State<CanceledTasksScreen> createState() => _CanceltedTasksScreenState();
}

class _CanceltedTasksScreenState extends State<CanceledTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ProfileSummaryCard(),

            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TasksItemCard();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
