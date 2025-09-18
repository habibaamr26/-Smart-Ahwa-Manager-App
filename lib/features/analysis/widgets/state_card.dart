

import 'package:flutter/material.dart';

import '../../../core/data/data.dart';
import '../../../core/models/order_model.dart';

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
          const SizedBox(height: 8),

        ],
      ),
    ),
  );
}

Widget buildDailySalesCard() {
  return buildStatCard(
    title: 'المبيعات اليومية',
    value: '${DataStore().dailySales(DateTime.now())} ج.م',
    icon: Icons.trending_up,
    color: const Color(0xFFE74C3C),
  );
}

Widget buildTotalOrdersCard() {
  return buildStatCard(
    title: 'إجمالي الطلبات',
    value: '${Order.numberOfOrders} طلب ',
    icon: Icons.assignment_turned_in,
    color: const Color(0xFF27AE60),
  );
}
