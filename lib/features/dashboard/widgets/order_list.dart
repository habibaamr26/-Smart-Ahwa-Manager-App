import 'package:flutter/material.dart';
import 'package:untitled/core/models/order_model.dart';
class OrdersList extends StatelessWidget {
  final List<Order> orders;
  final void Function(int orderId) onComplete; // <-- دالة تاخد orderId

  const OrdersList({
    Key? key,
    required this.orders,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (_, index) {
          final order = orders[index];
          return ListTile(
            title: Text('${order.customerName} — ${order.drinkType}'),
            subtitle: Text(
              (order.instructions)!.isEmpty
                  ? 'No instructions'
                  : order.notes!,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.check_circle ,
                color:Colors.grey,
              ),
              onPressed: () => onComplete(order.id), // <-- هنا نمرر الـ id
            ),
          );
        },
      ),
    );
  }
}
