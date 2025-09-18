
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/data/data.dart';
import '../../../core/models/order_model.dart';
import '../widgets/dropdown.dart';
class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  Drinks selectedDrink=Drinks.shai;
  TextEditingController nameController=TextEditingController();
  TextEditingController instructionController=TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: 'Customer name',
                          labelStyle:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.teal)
                          ),
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                              return "enter Customer name";
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text('Drink: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.teal),),
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
                          ],
                        ),
                        SizedBox(height:15),
                        TextField(
                          controller:instructionController ,
                          decoration: InputDecoration(labelText: 'Instructions',labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.teal)),
                        ),
                        SizedBox(height:15),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                    child: Text('Add Order',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.teal,),)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),);
  }
}
