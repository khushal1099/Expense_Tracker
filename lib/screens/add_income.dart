import 'dart:ffi';

import 'package:expense_tracker/firebase/FirebaseUtils.dart';
import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:expense_tracker/widgets/Textformfield.dart';
import 'package:expense_tracker/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/income_model.dart';
import '../utils/SizeUtils.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  void initState() {
    SizeUtils.config();
    super.initState();
  }

  final titleController = TextEditingController();
  final typeController = TextEditingController();
  final amountController = TextEditingController();
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final formatter = DateFormat.yMd();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorsUtil.lightBg,
        title: Text("Add Income"),
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
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Title";
                  }
                  return '';
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Income Type:-",
                style: TextStyle(color: ColorsUtil.lightBg),
              ),
              SizedBox(
                height: 5,
              ),
              TextformField(
                textController: typeController,
                hinttext: 'Enter Type',
                isPadding: false,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Income Type";
                  }
                  return '';
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
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please Enter Amount";
                  }
                  return '';
                },
              ),
              SizedBox(
                height: 15,
              ),
              IconButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final now = DateTime.now();
                  final firstDate = DateTime(now.year - 1, now.month, now.day);
                  var pickedDate = await showDatePicker(
                    context: context,
                    firstDate: firstDate,
                    lastDate: now,
                    initialDate: now,
                  );
                  if (pickedDate != null) selectedDate.value = pickedDate;
                  print(selectedDate.value);
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
                      FirebaseUtils.addIncomes(
                        Income(
                          title: titleController.text,
                          type: typeController.text,
                          amount: double.tryParse(amountController.text),
                          date: formatter.format(
                            selectedDate.value ?? DateTime.now(),
                          ),
                        ),
                      );
                    }
                    titleController.clear();
                    typeController.clear();
                    amountController.clear();
                    selectedDate.value = null;
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
