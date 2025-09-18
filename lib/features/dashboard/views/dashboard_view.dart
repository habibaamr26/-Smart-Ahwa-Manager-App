import 'package:flutter/material.dart';

import '../../../core/repository/repo_interface.dart';
import '../widgets/order_list.dart';

class Dashboard extends StatefulWidget {
  final OrderRepository repository;

  const Dashboard({super.key, required this.repository});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final orders = widget.repository.getOrders();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pending Orders: ${orders.length}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            OrdersList(
              orders: orders,
              onComplete: (orderId) {
                setState(() {
                  widget.repository.completeOrder(orderId);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
