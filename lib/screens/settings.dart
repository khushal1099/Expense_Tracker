import 'package:expense_tracker/controller/balance_controller.dart';
import 'package:expense_tracker/screens/authentication/login_screen.dart';
import 'package:expense_tracker/screens/incomes_expenses.dart';
import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
              print(data);
              if (data == null || data["image"] == null)
                return const Center(
                  child: CircularProgressIndicator(),
                );
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFAC0D4),
                      ),
                      child: Image.network(
                        data["image"],
                        width: 150,
                        fit: BoxFit.cover,
                        height: 150,
                        filterQuality: FilterQuality.low,
                        loadingBuilder: (context, child, loadingProgress) {
                          print(loadingProgress);
                          if ((loadingProgress?.cumulativeBytesLoaded ?? 0) <
                              (loadingProgress?.expectedTotalBytes ?? 0)) {
                            return Center(
                              child: const CircularProgressIndicator(),
                            );
                          }
                          return child;
                        },
                      ),
                    ),
                    Text(
                      data["name"] ?? "",
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    SettingsContainer(
                      text: "Incomes",
                      icon: Icons.import_export_rounded,
                      iconColor: Colors.green,
                      onTap: () {
                        Get.to(
                          () {
                            return Obx(
                              () {
                                var data = controller.incomeList.value;
                                return Incomes_Expenses(
                                  isPadding: true,
                                  isAppbar: true,
                                  list: data ?? [],
                                  isIncome: true,
                                );
                              },
                            );
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
                            return Obx(
                              () {
                                var data = controller.expenseList.value;
                                return Incomes_Expenses(
                                  isPadding: true,
                                  isAppbar: true,
                                  list: data ?? [],
                                  isIncome: false,
                                );
                              },
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
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.symmetric(
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
            Spacer(),
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
