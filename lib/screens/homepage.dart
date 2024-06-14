import 'package:expense_tracker/screens/add_expense.dart';
import 'package:expense_tracker/screens/add_income.dart';
import 'package:expense_tracker/screens/balance_page.dart';
import 'package:expense_tracker/screens/settings.dart';
import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pageview_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pagecontroller = Get.put(PageviewController());

  final List<Widget> pages = [
    BalancePage(),
    AddIncome(),
    AddExpense(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.darkBg,
      body: Obx(
        () => PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pagecontroller.pageController.value,
          onPageChanged: (value) {
            pagecontroller.onPageChanged(value);
          },
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.black54),
          child: BottomNavigationBar(
            currentIndex: pagecontroller.currentIndex.value,
            onTap: (value) {
              pagecontroller.changePage(value);
            },
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.import_export_rounded,
                  color: Colors.green,
                ),
                label: 'Income',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.import_export_rounded,
                  color: Colors.red,
                ),
                label: 'Expense',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
