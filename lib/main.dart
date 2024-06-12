import 'package:expense_tracker/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase/firebase_options.dart';
import 'screens/authentication/login_screen.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 119, 90, 246),
  );

  var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
  );

  var kDarkScheme = ColorScheme.fromSeed(seedColor: Colors.white);
  var kLightScheme = ColorScheme.fromSeed(seedColor: Colors.black);

  @override
  Widget build(BuildContext context) {
    var cu = FirebaseAuth.instance.currentUser;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: cu != null ? const HomePage() : const LoginScreen(),
    );
  }
}
