import 'package:flutter/material.dart';

class CanceledTasksScreen extends StatefulWidget {
  const CanceledTasksScreen({super.key});

  @override
  State<CanceledTasksScreen> createState() => _CanceltedTasksScreenState();
}

class _CanceltedTasksScreenState extends State<CanceledTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('New Task'),
      ),
    );
  }
}
