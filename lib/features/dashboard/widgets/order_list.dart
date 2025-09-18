import 'package:flutter/material.dart';
import 'package:untitled/core/models/order_model.dart';

class OrdersList extends StatelessWidget {
  final List<Order> orders;
  final void Function(int orderId) onComplete;

  const OrdersList({Key? key, required this.orders, required this.onComplete})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (_, index) {
          final order = orders[index];
          return ListTile(
            title: Text(
              '${order.customerName} — ${order.drinkType}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            subtitle: Text(
              (order.instructions)!.isEmpty ? 'No instructions' : order.notes!,
            ),
            trailing: IconButton(
              icon: Icon(Icons.check_circle, color: Colors.teal),
              onPressed: () => onComplete(order.id),
            ),
          );
        },
      ),
    );
  }
}
