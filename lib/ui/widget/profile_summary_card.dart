import 'package:flutter/material.dart';

import '../screen/edit_profile_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
    this.enabelOnTap = true,
  });
  final bool enabelOnTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (enabelOnTap) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(),
            ),
          );
        }
      },
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        'Yasin',
        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
      ),
      subtitle: Text(
        'yasin@gmail.com',
        style: TextStyle(color: Colors.white),
      ),
      trailing: enabelOnTap ? Icon(Icons.arrow_forward) : null,
      tileColor: Colors.green,
    );
  }
}
