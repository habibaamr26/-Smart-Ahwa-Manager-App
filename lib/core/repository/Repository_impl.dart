import 'package:untitled/core/repository/repo_interface.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final List<Order> _orders = [];

  @override
  void addOrder(Order order) {
    _orders.add(order);
  }

  @override
  void completeOrder(int orderId) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index].markCompleted();
      _orders.removeAt(index);
      Order.numberOfOrders--;
    }
  }

  @override
  double dailySales(DateTime day) {
    return _orders
        .where(
          (o) =>
              o.createdAt != null &&
              o.createdAt!.year == day.year &&
              o.createdAt!.month == day.month &&
              o.createdAt!.day == day.day,
        )
        .map((o) => o.drinkPrice)
        .fold(0.0, (a, b) => a + b);
  }

  @override
  Map<String, int> drinksTracking() {
    final Map<String, int> tracker = {};
    for (final order in _orders) {
      tracker[order.drinkType] = (tracker[order.drinkType] ?? 0) + 1;
    }
    return tracker;
  }

  @override
  List<Order> getOrders() => _orders;
}
