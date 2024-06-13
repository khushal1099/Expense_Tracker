import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/screens/authentication/signup_screen.dart';
import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:expense_tracker/widgets/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../widgets/Textformfield.dart';
import '../../widgets/button.dart';
import '../homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsUtil.darkBg,
      body: Center(
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    "assets/expense icon.png",
                  ),
                  height: 120,
                  width: 120,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: AnimatedTextkit(
                    widget: TypewriterAnimatedText(
                      "Join With Expense Tracker",
                      textStyle: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFAAE18),
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                    isRepeat: false,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: AnimatedTextkit(
                      widget: WavyAnimatedText(
                        "Log In",
                        textStyle: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.yellow,
                        ),
                      ),
                      isRepeat: true),
                ),
                TextformField(
                  hinttext: 'Enter Your Email',
                  icon: Icons.email,
                  textController: emailController,
                  isPadding: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Email";
                    } else if (!value.contains('@')) {
                      return "Please Enter Valid Email";
                    }
                    return null;
                  },
                ),
                TextformField(
                  hinttext: 'Enter Your password',
                  icon: Icons.lock,
                  textController: passwordController,
                  isPassword: true,
                  isPadding: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Password";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Button(
                  text: "Log In",
                  onTap: () async {
                    var cu = FirebaseAuth.instance.currentUser;
                    if (cu != null) {
                      print("Alredy Login");
                    } else {
                      UserCredential user = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      emailController.clear();
                      passwordController.clear();
                      Get.offAll(
                        HomePage(),
                      );
                    }
                  },
                  bRadius: 10,
                  bColor: Color(0xffFAAE18),
                  height: 40,
                  width: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create a New Account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignUpScreen(),
                            transition: Transition.cupertino);
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
