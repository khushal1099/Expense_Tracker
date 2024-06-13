import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/screens/authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("Users")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .get(),
            builder: (context, snapshot) {
              var data = snapshot.data?.data();
              print(data);
              if (data == null || data["image"] == null) {
                return const CircularProgressIndicator();
              }
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      data["image"],
                      width: 200,
                      fit: BoxFit.cover,
                      height: 200,
                      filterQuality: FilterQuality.low,
                      loadingBuilder: (context, child, loadingProgress) {
                        print(loadingProgress);
                        if ((loadingProgress?.cumulativeBytesLoaded ?? 0) <
                            (loadingProgress?.expectedTotalBytes ?? 0)) {
                          return const CircularProgressIndicator();
                        }
                        return child;
                      },
                    ),
                  ),
                  Text(
                    data["name"] ?? '',
                    style: const TextStyle(fontSize: 30),
                  )
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var cu = FirebaseAuth.instance.currentUser;
          if (cu != null) {
            await FirebaseAuth.instance.signOut();
            Get.offAll(const LoginScreen());
          }
        },
        child: const Icon(
          Icons.logout,
        ),
      ),
    );
  }
}
