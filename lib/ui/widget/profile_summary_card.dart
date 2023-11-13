import 'package:flutter/material.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        'Yasin',
        style:
        TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
      ),
      subtitle: Text(
        'yasin@gmail.com',
        style: TextStyle(color: Colors.white),
      ),
      trailing: Icon(Icons.arrow_forward),
      tileColor: Colors.green,
    );
  }
}
