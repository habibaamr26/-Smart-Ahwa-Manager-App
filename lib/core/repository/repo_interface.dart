// abstraction
import '../models/order_model.dart';

abstract class OrderRepository {
  void addOrder(Order order);
  void completeOrder(int orderId);
  double dailySales(DateTime day);
  Map<String, int> drinksTracking();
  List<Order> getOrders();
}
