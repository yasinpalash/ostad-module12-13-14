import 'package:flutter/material.dart';

import '../widget/profile_summary_card.dart';
import '../widget/summary_card.dart';
import '../widget/tasks_item_card.dart';
import 'add_new_task_screen.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewTaskScreen(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            const ProfileSummaryCard(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    SummaryCard(
                      count: '92',
                      title: 'New',
                    ),
                    SummaryCard(
                      count: '92',
                      title: 'In Progress',
                    ),
                    SummaryCard(
                      count: '92',
                      title: 'Completed',
                    ),
                    SummaryCard(
                      count: '92',
                      title: 'Cancelled',
                    ),
                  ],
                ),
              ),
            ),
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
