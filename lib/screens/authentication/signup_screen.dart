import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expense_tracker/models/authentication_models/add_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../main.dart';
import '../../utils/ColorsUtil.dart';
import '../../utils/SizeUtils.dart';
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
  void initState() {
    SizeUtils.config();
    super.initState();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Email";
                    } else if (!value.contains('@')) {
                      return "Please Enter Valid Email";
                    }
                    return '';
                  },
                ),
                TextformField(
                  hinttext: 'Enter Your password',
                  icon: Icons.lock,
                  textController: passwordController,
                  isPassword: true,
                  isPadding: true,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Password";
                    }
                    return '';
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Button(
                  text: "Sign Up",
                  onTap: () async {
                    // var cu = FirebaseAuth.instance.currentUser;

                    UserCredential user = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                    print("user:--- $user");
                    AddUserModel().addUser(user.user);
                    Get.offAll(
                      HomePage(),
                    );
                  },
                  bRadius: 10,
                  bColor: Color(0xffFAAE18),
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
