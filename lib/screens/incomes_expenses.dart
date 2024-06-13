import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/balance_controller.dart';
import '../utils/ColorsUtil.dart';

class Incomes_Expenses extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> list;
  final bool isIncome;

  const Incomes_Expenses({
    super.key,
    required this.list,
    required this.isIncome,
  });

  @override
  State<Incomes_Expenses> createState() => _Incomes_ExpensesState();
}

class _Incomes_ExpensesState extends State<Incomes_Expenses> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BalanceController());
    return Scaffold(
      backgroundColor: ColorsUtil.darkBg,
      body: widget.list.isEmpty
          ? Center(
              child: Center(child: CircularProgressIndicator()),
            )
          : ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                var inc = widget.list[index];
                return Card(
                  color: widget.isIncome
                      ? const Color(0xffa0ffa3)
                      : const Color(0xffff9ca9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: Row(
                          children: [
                            Text(
                              inc["title"],
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              inc["amount"].toString(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 3),
                        child: Row(
                          children: [
                            Text(
                              inc["type"],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              inc["date"],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
