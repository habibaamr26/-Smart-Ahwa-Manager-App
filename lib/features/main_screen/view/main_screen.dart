


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../add_order/view/add_order.dart';
import '../../analysis/view/analysis_view.dart';
import '../../dashboard/views/dashboard_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List Screens=[Dashboard(),AddOrder(),AnalysisView()];
  late int currentScreen=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('Ahwa Manager',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
      ),
      body:Screens[currentScreen] ,
     bottomNavigationBar: BottomNavigationBar(
       currentIndex: currentScreen,
         selectedItemColor: Colors.teal,
         onTap: (int index){
         setState(() {
           currentScreen=index;
         });
         },
         items: [
       BottomNavigationBarItem(icon:Icon( Icons.person),label: "loading"),
       BottomNavigationBarItem(icon:Icon( Icons.add),label: "order"),
       BottomNavigationBarItem(icon:Icon( Icons.analytics_outlined),label: "analysis"),
     ]),
    );
  }
}
