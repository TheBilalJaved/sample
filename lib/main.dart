import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ivoting/Screens/SignIn/SignIn.dart';
import 'package:ivoting/Screens/SignUp/SignUp.dart';
import 'package:ivoting/Screens/UserDashboard/UserDashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserDashboardScreen(),
    );
  }
}
