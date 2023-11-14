import 'package:flutter/material.dart';

class TasksItemCard extends StatelessWidget {
  const TasksItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title is here ',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text('Description'),
            Text('date:25-01-23 '),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Chip(
                  label: Text(
                    'New',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(

                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete_forever),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
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
}
