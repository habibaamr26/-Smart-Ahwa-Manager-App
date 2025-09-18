import 'package:flutter/material.dart';
import '../widgets/state_card.dart';
import '../widgets/track_items.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({Key? key}) : super(key: key);

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
                  buildDailySalesCard(),
                  SizedBox(width: 6,),
                  buildTotalOrdersCard(),  // خلصت تمام
                ],
              ),
            ),
            SizedBox(height: 10,),
            PopularItemsCard(),
          ],
        ),
      ),
    );
  }
}

