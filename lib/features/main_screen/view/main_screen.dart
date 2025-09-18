import 'package:flutter/material.dart';
import '../../../core/repository/repo_interface.dart';
import '../../add_order/view/add_order.dart';
import '../../analysis/view/analysis_view.dart';
import '../../dashboard/views/dashboard_view.dart';

class MainScreen extends StatefulWidget {
  final OrderRepository repository;

  const MainScreen({super.key, required this.repository});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Dashboard(repository: widget.repository),
      AddOrder(repository: widget.repository),
      AnalysisView(repository: widget.repository),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Ahwa Manager',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: screens[currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreen,
        selectedItemColor: Colors.teal,
        onTap: (int index) {
          setState(() {
            currentScreen = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Order"),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: "Analysis",
          ),
        ],
      ),
    );
  }
}
