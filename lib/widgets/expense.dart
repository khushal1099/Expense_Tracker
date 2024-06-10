import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/expense_model.dart';
import 'expenses_lists/expenses_list.dart';
import 'new_expense.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RxList<Expense> _serarchExpenses = <Expense>[
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ].obs;
  final RxList<Expense> _registeredExpenses = <Expense>[
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ].obs;

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    _registeredExpenses.add(expense);
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    _registeredExpenses.remove(expense);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            _registeredExpenses.insert(expenseIndex, expense);
          },
        ),
      ),
    );
  }

  void searchExpenses(String expense) {
    List<Expense> result = [];
    if (expense.isEmpty) {
      result = _registeredExpenses;
    } else {
      result = _registeredExpenses
          .where(
            (expenses) => expenses.title.toString().toLowerCase().contains(
                  expense.toLowerCase(),
                ),
          )
          .toList();
    }
    _serarchExpenses.value = result;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              _openAddExpenseOverlay();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(
        () {
          bool isDark =
              MediaQuery.of(context).platformBrightness == Brightness.dark;
          if (_registeredExpenses.isEmpty) {
            return Center(
              child: Text(
                "No Expense found. Start adding some!",
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
            );
          } else {
            return width < 600
                ? Column(
                    children: [
                      Chart(expense: _registeredExpenses),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              searchExpenses(value);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                                hintText: "Search Expenses",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ExpensesList(
                          expenses: _serarchExpenses,
                          onRemoveExpense: _removeExpense,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: Chart(expense: _registeredExpenses)),
                      Expanded(
                        child: ExpensesList(
                          expenses: _registeredExpenses,
                          onRemoveExpense: _removeExpense,
                        ),
                      ),
                    ],
                  );
          }
        },
      ),
    );
  }
}
