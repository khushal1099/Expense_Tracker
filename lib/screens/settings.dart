import 'package:expense_tracker/controller/balance_controller.dart';
import 'package:expense_tracker/screens/authentication/login_screen.dart';
import 'package:expense_tracker/screens/incomes_expenses.dart';
import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'edit_profile.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final controller = Get.put(BalanceController());

  @override
  Widget build(BuildContext context) {
    controller.getUserdata();
    return Scaffold(
      backgroundColor: ColorsUtil.darkBg,
      body: Center(
        child: SafeArea(
          child: Obx(
            () {
              var data = controller.user.value;
              if (data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFAC0D4),
                      ),
                      child: data["image"].isEmpty
                          ? const Center(
                              child: Icon(
                                Icons.person,
                                size: 100,
                              ),
                            )
                          : Image.network(
                              data["image"],
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high,
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                if (frame == null) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return child;
                              },
                            ),
                    ),
                    Center(
                      child: Text(
                        data["name"].toString().isEmpty
                            ? data["email"].toString().split("@").first
                            : data["name"] ?? '',
                        style: GoogleFonts.lato(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SettingsContainer(
                      text: "Edit Profile",
                      onTap: () {
                        Get.to(() => EditProfile());
                      },
                      icon: Icons.edit,
                    ),
                    SettingsContainer(
                      text: "Incomes",
                      icon: Icons.import_export_rounded,
                      iconColor: Colors.green,
                      onTap: () {
                        Get.to(
                          () {
                            return const IncomesExpenses(
                                isIncome: true, isAppbar: true);
                          },
                        );
                      },
                    ),
                    SettingsContainer(
                      text: "Expenses",
                      icon: Icons.import_export_rounded,
                      iconColor: Colors.red,
                      onTap: () {
                        Get.to(
                          () {
                            return const IncomesExpenses(
                              isIncome: false,
                              isAppbar: true,
                            );
                          },
                        );
                      },
                    ),
                    SettingsContainer(
                      text: "Logout",
                      icon: Icons.logout,
                      onTap: () async {
                        var cu = FirebaseAuth.instance.currentUser;
                        if (cu != null) {
                          await FirebaseAuth.instance.signOut();
                          await GoogleSignIn().signOut();
                          Get.offAll(const LoginScreen());
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SettingsContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  final void Function() onTap;

  const SettingsContainer({
    super.key,
    required this.text,
    required this.onTap,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: const Border.symmetric(
            horizontal: BorderSide(color: Colors.grey),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.lato(
                fontSize: 20,
              ),
            ),
            const Spacer(),
            Icon(
              icon,
              color: iconColor ?? Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
