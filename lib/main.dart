import 'package:flutter/material.dart';
import 'package:untitled/core/repository/Repository_impl.dart';
import 'core/repository/repo_interface.dart';
import 'features/main_screen/view/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final OrderRepository repo = OrderRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(repository: repo),
    );
  }
}
