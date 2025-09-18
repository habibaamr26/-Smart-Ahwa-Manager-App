import 'package:flutter/material.dart';
import '../../../core/models/order_model.dart';

import '../../../core/repository/repo_interface.dart';
import '../widgets/dropdown.dart';

class AddOrder extends StatefulWidget {
  final OrderRepository repository;

  const AddOrder({super.key, required this.repository});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  Drinks selectedDrink = Drinks.shai;
  TextEditingController nameController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Customer name',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.teal,
                            ),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Enter customer name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text(
                              'Drink: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(width: 12),
                            DrinksDropdown(
                              selectedDrink: selectedDrink,
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() {
                                    selectedDrink = v;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: instructionController,
                          decoration: const InputDecoration(
                            labelText: 'Instructions',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          widget.repository.addOrder(
                            Order(
                              customerName: nameController.text,
                              instructions: instructionController.text,
                              createdAt: DateTime.now(),
                              drinkType: selectedDrink,
                            ),
                          );
                          nameController.clear();
                          selectedDrink = Drinks.shai;
                          instructionController.clear();
                        });
                      }
                    },
                    child: const Text(
                      'Add Order',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
