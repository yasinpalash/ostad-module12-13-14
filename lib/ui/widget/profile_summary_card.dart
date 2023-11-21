import 'package:flutter/material.dart';
import 'package:module12/ui/controllers/auth_controller.dart';
import 'package:module12/ui/screen/login_screen.dart';

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
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        fullName,
        style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
      ),
      subtitle: Text(
        AuthController.user?.email??'',
        style: const TextStyle(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
        },
        icon: const Icon(Icons.login),
      ),
      tileColor: Colors.green,
    );
  }
  String get fullName{
    return '${AuthController.user?.firstName??''} ${AuthController.user?.lastName??''}';
  }
}
