import 'package:flutter/material.dart';
import '../../../core/repository/repo_interface.dart';
Widget buildStatCard({
  required String title,
  required String value,
  required IconData icon,
  required Color color,
}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDailySalesCard(OrderRepository repository) {
  final dailySales = repository.dailySales(DateTime.now());

  return buildStatCard(
    title: 'Daily Sales',
    value: '$dailySales  E.G',
    icon: Icons.trending_up,
    color: const Color(0xFFE74C3C),
  );
}

Widget buildTotalOrdersCard(OrderRepository repository) {
  return buildStatCard(
    title:"Total Orders",
    value: '${repository.getOrders().length} Order',
    icon: Icons.assignment_turned_in,
    color: const Color(0xFF27AE60),
  );
}
