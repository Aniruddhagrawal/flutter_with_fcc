import 'package:flutter/material.dart';
import 'package:flutter_with_fcc/Views/login_view.dart';
import 'package:flutter_with_fcc/Views/main_ui.dart';
import 'package:flutter_with_fcc/Views/register_view.dart';
import 'package:flutter_with_fcc/Views/verify_email_view.dart';
import 'package:flutter_with_fcc/constants/routes.dart';
import 'package:flutter_with_fcc/services/auth/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        mainUIRoute: (context) => const MainView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  // print('Your Email is Verified');
                  return const MainView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            // return const Text('DONE');
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
