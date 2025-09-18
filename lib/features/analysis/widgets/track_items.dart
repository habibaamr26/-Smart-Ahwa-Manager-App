import 'package:flutter/material.dart';

import '../../../core/repository/repo_interface.dart';

class PopularItemsCard extends StatelessWidget {
  final OrderRepository repository;

  const PopularItemsCard({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    final entries = repository.drinksTracking().entries.toList();

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF39C12).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Color(0xFFF39C12),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Popular items',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: entries.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = entries[index]; // MapEntry<String,int>
                  return PopularItemRow(item: item, index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularItemRow extends StatelessWidget {
  final MapEntry<String, int> item;
  final int index;

  const PopularItemRow({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.key,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${item.value}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
