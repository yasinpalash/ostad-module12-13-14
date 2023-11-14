import 'package:flutter/material.dart';

import '../widget/profile_summary_card.dart';
import '../widget/tasks_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
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
