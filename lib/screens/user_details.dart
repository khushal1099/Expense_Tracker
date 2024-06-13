import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/controller/image_controller.dart';
import 'package:expense_tracker/firebase/FirebaseUtils.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/screens/homepage.dart';
import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:expense_tracker/widgets/Textformfield.dart';
import 'package:expense_tracker/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final nameController = TextEditingController();
  final imageControlller = ImageController();
  bool isLoading = false;

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
                      backgroundImage: imageControlller.image.isNotEmpty
                          ? FileImage(
                              File(imageControlller.image.value),
                            )
                          : null,
                      child: imageControlller.image.isEmpty
                          ? Icon(
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
                        imageControlller.addcameraimage();
                      },
                      icon: Icon(
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
                        imageControlller.addgalleryimage();
                      },
                      icon: Icon(
                        Icons.photo,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
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
              SizedBox(
                height: 30,
              ),
              Button(
                text: 'Save',
                isLoading: isLoading,
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  try {
                    final cu = FirebaseAuth.instance.currentUser;
                    if (cu != null) {
                      final imageName =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      isLoading = true;
                      setState(() {});
                      final storageRef = FirebaseStorage.instance
                          .ref()
                          .child("Profile_Picture/$imageName.png");
                      final i = await storageRef.putFile(
                        File(imageControlller.image.value),
                        SettableMetadata(contentType: 'image/png'),
                      );

                      final path = await i.ref.getDownloadURL();
                      print("images:------ $path");

                      AuthUser authuser = AuthUser(
                        email: cu.email,
                        image: path.toString(),
                        name: nameController.text,
                      );
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(cu.uid)
                          .update(authuser.toJson());
                      Get.offAll(HomePage());
                    }
                  } on FirebaseStorage catch (e) {
                    print('error-------${e}');
                  }
                },
                bRadius: 10,
                bColor: Colors.blue,
                textColor: Colors.white,
                height: 40,
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
