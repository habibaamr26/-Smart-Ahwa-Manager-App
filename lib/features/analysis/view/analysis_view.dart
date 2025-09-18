import 'package:flutter/material.dart';

import '../../../core/repository/repo_interface.dart';
import '../widgets/state_card.dart';
import '../widgets/track_items.dart';
class AnalysisView extends StatefulWidget {
  final OrderRepository repository;

  const AnalysisView({Key? key, required this.repository}) : super(key: key);

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Stats Grid
            Expanded(
              child: Row(
                children: [
                  buildDailySalesCard(widget.repository),
                  const SizedBox(width: 6),
                  buildTotalOrdersCard(widget.repository),
                ],
              ),
            ),
            const SizedBox(height: 10),
            PopularItemsCard(repository: widget.repository),
          ],
        ),
      ),
    );
  }
}
