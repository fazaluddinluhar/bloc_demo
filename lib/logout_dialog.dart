import 'package:bloc_demo/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
        CupertinoDialogAction(
          onPressed: () {
            perfValue(false);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                    (Route<dynamic> route) => false);
            //Navigator.of(context).pushReplacementNamed('/login');
          },
          isDestructiveAction: true,
          child: const Text("Logout"),
        ),
      ],
    );
  }

  perfValue(bool isLoginValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', isLoginValue);
  }
}
