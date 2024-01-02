import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.addNewExpense});

  final void Function(Expense) addNewExpense;

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selDate;
  var selectedCategory = Category.leisure;

  void calendar() async {
    final now = DateTime.now();
    DateTime firstDate = DateTime(now.year - 20, now.month, now.day);
    DateTime lastDate = now;
    selDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
    setState(
      () {
        selDate;
      },
    );
  }

  void submitData() {
    final amount = double.tryParse(amountController.text);
    var amountChecker = amount == null || amount <= 0;
    if (titleController.text.trim().isEmpty ||
        amountChecker ||
        selDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text('Add valid info'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay'),
                ),
              ],
            );
          });
      return;
    }
    widget.addNewExpense(
      Expense(
          title: titleController.text,
          date: selDate!,
          amount: amount,
          category: selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + keyboardHeight),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                            ),
                            maxLength: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 26,
                        ),
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('Amount'),
                              prefix: Text('\$'),
                            ),
                            maxLength: 15,
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                      maxLength: 50,
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                          value: selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(
                              () {
                                selectedCategory = value;
                              },
                            );
                          },
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              selDate == null
                                  ? 'Select Date'
                                  : formatter.format(selDate!),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            IconButton(
                              onPressed: calendar,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('Amount'),
                              prefix: Text('\$'),
                            ),
                            maxLength: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 26,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              selDate == null
                                  ? 'Select Date'
                                  : formatter.format(selDate!),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            IconButton(
                              onPressed: calendar,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ],
                    ),
                  if (width >= 600)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: submitData,
                          child: const Text('Add Expense'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                          value: selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(
                              () {
                                selectedCategory = value;
                              },
                            );
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: submitData,
                          child: const Text('Add Expense'),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
