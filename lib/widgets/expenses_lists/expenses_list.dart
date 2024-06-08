import 'package:expense_tracker/widgets/expenses_lists/expenses_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/expense_model.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
  });

  final RxList<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]),
    );
  }
}
