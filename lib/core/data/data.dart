


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
    }
  }
}
