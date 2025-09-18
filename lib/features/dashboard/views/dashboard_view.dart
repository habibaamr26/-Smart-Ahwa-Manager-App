

import 'package:flutter/material.dart';
import 'package:untitled/core/data/data.dart';

import '../../../core/models/order_model.dart';
import '../widgets/dropdown.dart';
import '../widgets/order_list.dart';
class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
  Drinks selectedDrink=Drinks.shai;
  TextEditingController nameController=TextEditingController();
  TextEditingController instructionController=TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
      appBar: AppBar(
        title: Text('Ahwa Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {

            },
            tooltip: 'Top selling',
          ),
          IconButton(
            icon: Icon(Icons.insert_chart),
            onPressed: () {},
            tooltip: 'Summary',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Customer name'),
                      validator: (String? value)
                      {
                        if(value!.isEmpty)
                          return "enter Customer name";
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Drink: '),
                        SizedBox(width: 12),
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
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller:instructionController ,
                            decoration: InputDecoration(labelText: 'Instructions'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate())
                          {
                            setState(() {
                              DataStore().addOrder(
                                order: Order(
                                  customerName: nameController.text,
                                  instructions: instructionController.text,
                                  createdAt: DateTime.now(),
                                  drinkType: selectedDrink,
                                ),
                              );
                              nameController.clear();
                              selectedDrink=Drinks.shai;
                              instructionController.clear();
                            });
                          }
                      },
                      child: Text('Add Order'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            // Pending orders dashboard (UI بس)
            Text('Pending Orders: ${DataStore().orders.length}',
                style: TextStyle(fontSize: 16)),
            OrdersList(
              orders: DataStore().orders,
              onComplete: (orderId) {
                setState(() {
                  DataStore().completeOrder(orderId);
                });
              },
            )
          ],
        ),
      ),
    ),);
  }
}
