import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/controller/image_controller.dart';
import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/screens/homepage.dart';
import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:expense_tracker/widgets/Textformfield.dart';
import 'package:expense_tracker/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/Utils.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final nameController = TextEditingController();
  final imageController = ImageController();
  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.darkBg,
      appBar: AppBar(
        backgroundColor: ColorsUtil.darkBg,
        title: Text(
          "Personal Details",
          style: TextStyle(
            color: ColorsUtil.lightBg,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Obx(
                    () => CircleAvatar(
                      maxRadius: 70,
                      backgroundImage: imageController.image.isNotEmpty
                          ? FileImage(
                              File(imageController.image.value),
                            )
                          : null,
                      child: imageController.image.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 80,
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        imageController.addcameraimage();
                      },
                      icon: const Icon(
                        Icons.photo_camera,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        imageController.addgalleryimage();
                      },
                      icon: const Icon(
                        Icons.photo,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextformField(
                hinttext: 'Enter Your Name',
                textController: nameController,
                isPadding: false,
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => Button(
                  text: 'Save',
                  isLoading: isLoading.value,
                  onTap: () async {
                    isLoading.value = true;
                    final cu = FirebaseAuth.instance.currentUser;
                    var imageStorage =
                        await Utils.imageStorage(imageController.image.value);
                    await cu?.updateDisplayName(nameController.text);
                    await cu?.updatePhotoURL(imageStorage.toString());

                    AuthUser authuser = AuthUser(
                      email: cu?.email,
                      image: imageStorage.toString(),
                      name: nameController.text,
                    );
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(cu?.uid)
                        .update(authuser.toJson());
                    Get.offAll(const HomePage());
                  },
                  bRadius: 10,
                  bColor: Colors.blue,
                  textColor: Colors.white,
                  height: 40,
                  width: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
