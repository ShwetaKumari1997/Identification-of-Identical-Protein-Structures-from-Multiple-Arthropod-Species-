import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:protein_database/pages/CRUD/create.dart';
import 'package:protein_database/pages/CRUD/delete1.dart';
import 'package:protein_database/pages/CRUD/update.dart';
import 'package:protein_database/pages/CRUD/update_edittext.dart';
import 'package:protein_database/pages/auth/login.dart';
import 'package:protein_database/pages/auth/signup.dart';
import 'package:protein_database/pages/crud_page.dart';
import 'package:protein_database/pages/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyABU1JrNEI8srP758pF6uowaKKxKjWJ2lY",
      appId: "1:821933535809:web:4363c701c6e10b770dccc0",
      messagingSenderId: "821933535809",
      projectId: "protein-data-f17e2",
      storageBucket: "protein-data-f17e2.appspot.com"
    ),
  );
  runApp( MyApp() );
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
      routes: {
        // '/' : (context) => const LoginPage(),
        '/' : (context) => const LoginPage(),
        '/create' : (context) => const Create1(),
        '/delete' : (context) => const Delete1(),
        '/update' : (context) => const Update1(),
        '/update_edit': (context) => const UpdateEditText(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/crud_page': (context) => const CrudPage(),
      },
    );
  }
}
