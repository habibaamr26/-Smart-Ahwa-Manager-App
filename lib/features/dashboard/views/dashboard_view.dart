import 'package:flutter/material.dart';
import 'package:untitled/core/data/data.dart';
import '../widgets/order_list.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pending Orders: ${DataStore().orders.length}',
              style: TextStyle(fontSize: 20,color: Colors.teal,fontWeight: FontWeight.bold)),
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
        );
  }
}
