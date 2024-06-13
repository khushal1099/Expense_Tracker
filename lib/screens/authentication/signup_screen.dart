import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expense_tracker/firebase/FirebaseUtils.dart';
import 'package:expense_tracker/screens/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../main.dart';
import '../../utils/ColorsUtil.dart';
import '../../widgets/Textformfield.dart';
import '../../widgets/animated_text_kit.dart';
import '../../widgets/button.dart';
import '../homepage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.darkBg,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: const AssetImage(
                    "assets/expense icon.png",
                  ),
                  height: 120,
                  width: 120,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: AnimatedTextkit(
                    widget: TypewriterAnimatedText(
                      "Join With Expense Tracker",
                      textStyle: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffFAAE18),
                      ),
                      speed: const Duration(milliseconds: 100),
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
                        "Sign Up",
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
                const SizedBox(height: 30),
                Button(
                  text: "Sign Up",
                  isLoading: isLoading,
                  onTap: () async {
                    try {
                      var cu = FirebaseAuth.instance.currentUser;
                      if (cu != null) {
                        print("Alredy Signup");
                      } else {
                        if (_formkey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          UserCredential user = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          print("user:--- $user");
                          FirebaseUtils.addUser(user.user);
                          Get.offAll(const UserDetails());
                        }
                      }
                    } on FirebaseAuthException catch (e) {
                      print('error-------${e.message}');
                      print(e.code);
                    }
                  },
                  bRadius: 10,
                  bColor: const Color(0xffFAAE18),
                  height: 40,
                  width: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
