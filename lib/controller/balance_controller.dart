import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/firebase/FirebaseUtils.dart';
import 'package:get/get.dart';

class BalanceController extends GetxController {
  RxDouble totalIncome = 0.0.obs;
  RxDouble totalExpense = 0.0.obs;
  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> incomeList = Rx(null);
  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> expenseList = Rx(null);

  Future<void> getExpense() async {
    expenseList.value = await FirebaseUtils.getExpense();

    double v = 0;
    if (expenseList.value != null) {
      for (var doc in expenseList.value!) {
        v += doc['amount'] ?? 0;
      }
    }
    totalExpense.value = v;
  }

  Future<void> getIncome() async {
    incomeList.value = await FirebaseUtils.getIncome();

    double v = 0;
    if (incomeList.value != null) {
      for (var doc in incomeList.value!) {
        v += doc['amount'] ?? 0;
      }
    }
    totalIncome.value = v;
  }
}
