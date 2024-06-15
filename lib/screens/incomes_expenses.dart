import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/controller/balance_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/ColorsUtil.dart';

class Incomes_Expenses extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> list;
  final bool isIncome;
  final bool? isAppbar;
  final bool? isPadding;

  const Incomes_Expenses({
    super.key,
    required this.list,
    required this.isIncome,
    this.isAppbar = false,
    this.isPadding,
  });

  @override
  State<Incomes_Expenses> createState() => _Incomes_ExpensesState();
}

class _Incomes_ExpensesState extends State<Incomes_Expenses> {
  final controller = Get.put(BalanceController());
  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>> dataList =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  QueryDocumentSnapshot<Map<String, dynamic>>? _lastDeletedItem;
  int _lastDeleteIndex = -1;

  @override
  void initState() {
    dataList.value = widget.list;
    super.initState();
  }

  Future<void> _deleteItem(String docId) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(widget.isIncome ? "Incomes" : "Expenses")
        .doc(docId)
        .delete();
    print("deleted succesfully");
  }

  void _undoDelete() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(widget.isIncome ? "Incomes" : "Expenses")
        .doc(_lastDeletedItem?.id)
        .set(_lastDeletedItem!.data());

    dataList.insert(_lastDeleteIndex, _lastDeletedItem!);

    _lastDeletedItem = null;
    _lastDeleteIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.darkBg,
      appBar: widget.isAppbar == true
          ? AppBar(
              backgroundColor: ColorsUtil.darkBg,
              foregroundColor: Colors.white,
              title: Text(widget.isIncome ? "Incomes" : "Expenses"),
              centerTitle: true,
            )
          : null,
      body: dataList.isEmpty
          ? Center(
              child: Text(
                widget.isIncome ? "Add Incomes" : "Add Expenses",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : Obx(
              () => ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  var inc = dataList[index];
                  if (dataList.isEmpty) {
                    return Center(
                      child: Text(
                        widget.isIncome ? "Add Incomes" : "Add Expenses",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: widget.isPadding == true
                        ? const EdgeInsets.symmetric(horizontal: 20)
                        : EdgeInsets.zero,
                    child: Dismissible(
                      key: ValueKey(dataList[index]),
                      onDismissed: (direction) async {
                        _lastDeletedItem = dataList[index];
                        _lastDeleteIndex = index;
                        dataList.removeAt(index);
                        widget.isIncome
                            ? controller.getIncome()
                            : controller.getExpense();
                        dataList.refresh();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 3),
                            content: Text(
                                '${widget.isIncome ? "Income" : "Expense"} deleted successfully'),
                            action: SnackBarAction(
                              label: "Undo",
                              onPressed: () {
                                _undoDelete();
                              },
                            ),
                          ),
                        );
                        Future.delayed(
                          const Duration(seconds: 5),
                          () async {
                            if (_lastDeletedItem != null) {
                              await _deleteItem(_lastDeletedItem!.id);
                              _lastDeletedItem = null;
                              _lastDeleteIndex = -1;
                              widget.isIncome
                                  ? controller.getIncome()
                                  : controller.getExpense();
                            }
                          },
                        );
                      },
                      child: Card(
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
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
