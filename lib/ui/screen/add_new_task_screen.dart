import 'package:flutter/material.dart';
import 'package:module12/data.network_caller/network_caller.dart';
import 'package:module12/data.network_caller/network_response.dart';
import 'package:module12/ui/widget/body_background.dart';
import 'package:module12/ui/widget/profile_summary_card.dart';
import 'package:module12/ui/widget/snack_bar.dart';

import '../../data.network_caller/Utility/urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _createNewTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Add New Task',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _subjectTEController,
                            decoration:
                                const InputDecoration(hintText: 'Subject'),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter Your Subject';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _descriptionTEController,
                            maxLines: 8,
                            decoration:
                                const InputDecoration(hintText: 'Description'),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter Your description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: _createNewTaskInProgress == false,
                              replacement: const Center(
                                  child: CircularProgressIndicator()),
                              child: ElevatedButton(
                                onPressed: createTask,
                                child: const Icon(
                                    Icons.arrow_circle_right_outlined),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createTask() async {
    if (_formKey.currentState!.validate()) {
      _createNewTaskInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.createNewTask, body: {
        "title": _subjectTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        "status": "New"
      });
      _createNewTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        _subjectTEController.clear();
        _descriptionTEController.clear();
        if (mounted) {
          showSnackMessage(context, 'New task added');
        }
      } else {
        if (mounted) {
          showSnackMessage(
              context, 'Create New task failed! please try again', true);
        }
      }
    }
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
