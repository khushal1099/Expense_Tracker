import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/models/income_model.dart';

class FirebaseUtils {
  FirebaseUtils._();

  static String expenses = "Expenses";
  static String incomes = "Incomes";

  static Stream<List<Expense>> getExpanse() {
    var v = FirebaseFirestore.instance.collection(expenses).snapshots();
    var e = v.map((event) => event.docs.map((e) {
          var i = e.data();
          return Expense(
              title: i['title'],
              amount: i['amount'],
              date: i['date'],
              type: i['type']);
        }).toList());

    return e;
  }

  static void addExpenses(Expense expense) {
    FirebaseFirestore.instance.collection(expenses).add(
      {
        "title": expense.title,
        "amount": expense.amount,
        "date": expense.date,
        "type": expense.type,
      },
    ).then((value) {
      print("Expense Added Successfully");
    });
  }

  static void addIncomes(Income income) {
    FirebaseFirestore.instance.collection(incomes).add(
      {
        "title": income.title,
        "amount": income.amount,
        "date": income.date,
        "type": income.type,
      },
    ).then((value) {
      print("Income Added Successfully");
    });
  }
}
