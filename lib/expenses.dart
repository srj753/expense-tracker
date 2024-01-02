import 'package:expense_tracker/add_expense.dart';
import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  List<Expense> registeredExpenses = [
    Expense(
      title: 'Flutter',
      amount: 26.54,
      category: Category.work,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Movie',
      amount: 14.99,
      category: Category.leisure,
      date: DateTime.now(),
    )
  ];

  void addNewExpense(Expense newExpense) {
    setState(() {
      registeredExpenses.add(newExpense);
    });
  }

  void removeExpense(Expense expense) {
    final index = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                registeredExpenses.insert(index, expense);
              },
            );
          },
        ),
      ),
    );
  }

  void openAddOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      //backgroundColor: Colors.white,
      context: context,
      builder: ((context) => AddExpense(
            addNewExpense: addNewExpense,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expense added. Try adding some!'),
    );
    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
          expenses: registeredExpenses, removeExpense: removeExpense);
    }

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses App'),
        actions: [
          IconButton(
            onPressed: () {
              openAddOverlay();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width >= 600
          ? Row(children: [
              Expanded(child: Chart(expenses: registeredExpenses)),
              Expanded(child: mainContent)
            ])
          : Column(
              children: [
                Chart(expenses: registeredExpenses),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
