import 'package:expense_tracker/widgets/expenses_lists/expenses_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../models/expense_model.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final RxList<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index]),
        ),
      ),
    );
  }
}
