// main.dart
import 'package:flutter/material.dart';

import 'features/dashboard/views/dashboard_view.dart';
import 'features/main_screen/view/main_screen.dart';

void main() {
  runApp( MyApp());
}




class MyApp extends StatelessWidget {
  //late final OrderService service;

  //@override
 /* void initState() {
    super.initState();
    // Dependency injection: pass repository implementation (DIP)
    service = OrderService(repository: InMemoryOrderRepository());
    service.loadOrders();
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}











/*
// -------------------- Models (Encapsulation) --------------------
class Order {
  String _customerName;
  String _drinkType;
  String _instructions;
  bool _completed;
  final String id;
  final DateTime createdAt;

  Order({
    required this.id,
    required String customerName,
    required String drinkType,
    String instructions = '',
    bool completed = false,
    DateTime? createdAt,
  })  : _customerName = customerName,
        _drinkType = drinkType,
        _instructions = instructions,
        _completed = completed,
        createdAt = createdAt ?? DateTime.now();

  // getters (encapsulation)
  String get customerName => _customerName;
  String get drinkType => _drinkType;
  String get instructions => _instructions;
  bool get completed => _completed;

  // setters with simple validation
  set customerName(String v) {
    if (v.trim().isEmpty) throw Exception('Customer name cannot be empty');
    _customerName = v;
  }

  set drinkType(String v) {
    if (v.trim().isEmpty) throw Exception('Drink type cannot be empty');
    _drinkType = v;
  }

  void markCompleted() {
    _completed = true;
  }
}

// -------------------- Persistence Abstraction (DIP) --------------------
abstract class OrderRepository {
  Future<void> addOrder(Order order);
  Future<List<Order>> getOrders();
  Future<void> updateOrder(Order order);
}

// Simple in-memory implementation
class InMemoryOrderRepository implements OrderRepository {
  final List<Order> _storage = [];

  @override
  Future<void> addOrder(Order order) async {
    _storage.add(order);
  }

  @override
  Future<List<Order>> getOrders() async {
    // return copy
    return List<Order>.from(_storage);
  }

  @override
  Future<void> updateOrder(Order order) async {
    final idx = _storage.indexWhere((o) => o.id == order.id);
    if (idx != -1) _storage[idx] = order;
  }
}

// -------------------- Business Logic (SRP) --------------------
class OrderService extends ChangeNotifier {
  final OrderRepository repository;
  List<Order> _orders = [];

  OrderService({required this.repository});

  List<Order> get orders => List.unmodifiable(_orders);

  Future<void> loadOrders() async {
    _orders = await repository.getOrders();
    notifyListeners();
  }

  Future<void> addOrder(Order o) async {
    await repository.addOrder(o);
    await loadOrders();
  }

  Future<void> completeOrder(String id) async {
    final o = _orders.firstWhere((x) => x.id == id);
    o.markCompleted();
    await repository.updateOrder(o);
    await loadOrders();
  }

  // small helper to compute dashboard data
  Map<String, int> topSelling() {
    final counts = <String, int>{};
    for (var o in _orders) {
      counts[o.drinkType] = (counts[o.drinkType] ?? 0) + 1;
    }
    return counts;
  }

  int totalServed() => _orders.where((o) => o.completed).length;
}

// -------------------- Reporting (Open for extension via Polymorphism) --------------------
abstract class ReportStrategy {
  String generate(OrderService service);
}

class TopSellingReport implements ReportStrategy {
  @override
  String generate(OrderService service) {
    final map = service.topSelling();
    if (map.isEmpty) return 'No orders yet';
    final sorted = map.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.map((e) => '${e.key}: ${e.value}').join('\n');
  }
}

class SummaryReport implements ReportStrategy {
  @override
  String generate(OrderService service) {
    final total = service.orders.length;
    final served = service.totalServed();
    return 'Total orders: $total\nServed: $served';
  }
}

// -------------------- UI --------------------
class AhwaApp extends StatefulWidget {
  @override
  State<AhwaApp> createState() => _AhwaAppState();
}

class _AhwaAppState extends State<AhwaApp> {
  late final OrderService service;

  @override
  void initState() {
    super.initState();
    // Dependency injection: pass repository implementation (DIP)
    service = OrderService(repository: InMemoryOrderRepository());
    service.loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(orderService: service),
    );
  }
}
















class HomePage extends StatefulWidget {
  final OrderService orderService;
  HomePage({required this.orderService});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _customerCtrl = TextEditingController();
  final _instructionsCtrl = TextEditingController();
  String _selectedDrink = 'Shai';

  @override
  void dispose() {
    _customerCtrl.dispose();
    _instructionsCtrl.dispose();
    super.dispose();
  }

  void _addOrder() async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final order = Order(
      id: id,
      customerName: _customerCtrl.text,
      drinkType: _selectedDrink,
      instructions: _instructionsCtrl.text,
    );
    try {
      await widget.orderService.addOrder(order);
      _customerCtrl.clear();
      _instructionsCtrl.clear();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _showReport(ReportStrategy strategy) {
    final text = strategy.generate(widget.orderService);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Report'),
        content: Text(text),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = widget.orderService.orders;
    final pending = orders.where((o) => !o.completed).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Ahwa Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () => _showReport(TopSellingReport()),
            tooltip: 'Top selling',
          ),
          IconButton(
            icon: Icon(Icons.insert_chart),
            onPressed: () => _showReport(SummaryReport()),
            tooltip: 'Summary',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Add order form
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      controller: _customerCtrl,
                      decoration: InputDecoration(labelText: 'Customer name'),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Drink: '),
                        SizedBox(width: 12),
                        DropdownButton<String>(
                          value: _selectedDrink,
                          items: ['Shai', 'Turkish', 'Hibiscus']
                              .map((d) => DropdownMenuItem(
                            value: d,
                            child: Text(d),
                          ))
                              .toList(),
                          onChanged: (v) => setState(() => _selectedDrink = v!),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _instructionsCtrl,
                            decoration: InputDecoration(labelText: 'Instructions'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(onPressed: _addOrder, child: Text('Add Order')),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            // Pending orders dashboard
            Text('Pending Orders: ${pending.length}', style: TextStyle(fontSize: 16)),
            Expanded(
              child: ListView.builder(
                itemCount: pending.length,
                itemBuilder: (_, idx) {
                  final o = pending[idx];
                  return ListTile(
                    title: Text('${o.customerName} — ${o.drinkType}'),
                    subtitle: Text(o.instructions.isEmpty ? 'No instructions' : o.instructions),
                    trailing: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () async {
                        await widget.orderService.completeOrder(o.id);
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/