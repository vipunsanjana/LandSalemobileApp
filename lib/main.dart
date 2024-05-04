import 'package:ecomm/screen/SelectBuddy/SelectTravelBuddy.dart';
import 'package:ecomm/screen/landing/landing.dart';
import 'package:flutter/material.dart';
//import 'package:travelup/screen/landing/landing.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}