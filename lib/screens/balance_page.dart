import 'package:expense_tracker/screens/expeses.dart';
import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:expense_tracker/utils/SizeUtils.dart';
import 'package:expense_tracker/widgets/container.dart';
import 'package:flutter/material.dart';

import 'incomes.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorsUtil.darkBg,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
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
              const SizedBox(
                height: 20,
              ),
              const ContainerWidget(
                height: 100,
                width: 150,
                borderRadius: 10,
                colors: [Colors.lightBlue, Colors.yellow],
                text: 'Balance',
                iconcolor: Colors.white,
                icon: Icons.account_balance_wallet,
              ),
              Container(
                height: 50,
                width: SizeUtils.width,
                color: Colors.white,
                child: const TabBar(
                  tabs: [
                    Text("Incomes"),
                    Text("Expenses"),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [Incomes(), Expenses()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
