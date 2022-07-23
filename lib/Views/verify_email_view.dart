import 'package:flutter/material.dart';
import 'package:flutter_with_fcc/constants/routes.dart';
import 'package:flutter_with_fcc/services/auth/auth_service.dart';
import 'dart:developer' as devtools show log;

import 'package:flutter_with_fcc/utilities/show_error_dialog.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const Text("We've sent you an Email...Please Check Your Inbox..."),
          const Text("If you haven't recieved a verifiacation email yet..."),
          TextButton(
            onPressed: () async {
              try {
                await AuthService.firebase().sendEmailVerification();
                // final user = FirebaseAuth.instance.currentUser;
                // await user?.sendEmailVerification();
                await showErrorDialog(context, 'Sent');
              } catch (e) {
                devtools.log(e.toString());
              }
            },
            child: const Text('Press Here'),
          ),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text('Restart'))
        ],
      ),
    );
  }
}
