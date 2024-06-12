import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:expense_tracker/widgets/container.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.darkBg,
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ContainerWidget(
                  height: 100,
                  width: 150,
                  borderRadius: 10,
                  colors: [Colors.green, Colors.yellow],
                  text: 'Income',
                  iconcolor: Colors.green,
                  icon: Icons.import_export_rounded,
                ),
                ContainerWidget(
                  height: 100,
                  width: 150,
                  borderRadius: 10,
                  colors: [Colors.red, Colors.yellow],
                  text: 'Expense',
                  iconcolor: Colors.red,
                  icon: Icons.import_export_rounded,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ContainerWidget(
              height: 100,
              width: 150,
              borderRadius: 10,
              colors: [Colors.lightBlue, Colors.yellow],
              text: 'Balance',
              iconcolor: Colors.white,
              icon: Icons.account_balance_wallet,
            ),
          ],
        ),
      ),
    );
  }
}
