import 'package:expense_tracker/controller/balance_controller.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../firebase/FirebaseUtils.dart';
import '../utils/ColorsUtil.dart';
import '../widgets/Textformfield.dart';
import '../widgets/button.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final titleController = TextEditingController();
  final typeController = TextEditingController();
  final amountController = TextEditingController();
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final formatter = DateFormat.yMd();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final controller = Get.put(BalanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorsUtil.lightBg,
        title: Text("Add Expense"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              Text(
                "Title:-",
                style: TextStyle(color: ColorsUtil.lightBg),
              ),
              SizedBox(
                height: 5,
              ),
              TextformField(
                textController: titleController,
                hinttext: 'Enter title',
                isPadding: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Title";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Expense Type:-",
                style: TextStyle(color: ColorsUtil.lightBg),
              ),
              SizedBox(
                height: 5,
              ),
              TextformField(
                textController: typeController,
                hinttext: 'Enter Type',
                isPadding: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Expense Type";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Amount:-",
                style: TextStyle(color: ColorsUtil.lightBg),
              ),
              SizedBox(
                height: 5,
              ),
              TextformField(
                textController: amountController,
                hinttext: 'Enter Amount',
                isPadding: false,
                isNumber: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Amount";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              IconButton(
                onPressed: () async {
                  final now = DateTime.now();
                  final firstDate = DateTime(now.year - 1, now.month, now.day);
                  var pickedDate = await showDatePicker(
                    context: context,
                    firstDate: firstDate,
                    lastDate: now,
                    initialDate: now,
                  );
                  if (pickedDate != null) selectedDate.value = pickedDate;
                  // print(selectedDate.value);
                },
                icon: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => Text(
                        selectedDate.value == null
                            ? 'Pick Date'
                            : formatter
                                .format(selectedDate.value ?? DateTime.now()),
                        style: TextStyle(color: ColorsUtil.lightBg),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Button(
                  text: 'Save',
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      FirebaseUtils.addExpenses(
                        Expense(
                          title: titleController.text,
                          type: typeController.text,
                          amount: double.tryParse(amountController.text),
                          date: formatter.format(
                            selectedDate.value ?? DateTime.now(),
                          ),
                        ),
                      );

                      controller.getExpense();

                      titleController.clear();
                      typeController.clear();
                      amountController.clear();
                      selectedDate.value = null;
                    }
                  },
                  bRadius: 10,
                  bColor: Colors.blue,
                  height: 40,
                  width: 120,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
