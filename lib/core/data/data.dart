


import '../models/order_model.dart';
class DataStore {
  DataStore._internal();

  static final DataStore _instance = DataStore._internal();
  factory DataStore() => _instance;

  final List<Order> orders = [];

  void addOrder({required Order order}) {
    print(order.createdAt);
    orders.add(order);
  }

  void completeOrder(int orderId) {
    final index = orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      orders[index].markCompleted();
      orders.removeAt(index);
      Order.numberOfOrders--;
    }
  }


  double dailySales(DateTime day) {
    return orders
        .where((o) =>
    o.createdAt != null &&
        o.createdAt!.year == day.year &&
        o.createdAt!.month == day.month &&
        o.createdAt!.day == day.day)
        .map((o) => o.drinkPrice)
        .fold(0.0, (a, b) => a + b);
  }


  Map<String, int> drinksTracking() {
    final Map<String, int> tracker = {};
    for (final order in orders) {
      final drink = order.drinkType;
      tracker[drink] = (tracker[drink] ?? 0) + 1;
    }
    return tracker;
  }

}
