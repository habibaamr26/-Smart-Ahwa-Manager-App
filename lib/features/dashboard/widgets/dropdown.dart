import 'package:flutter/material.dart';
import '../../../core/models/order_model.dart';

class DrinksDropdown extends StatelessWidget {
  final Drinks selectedDrink;
  final ValueChanged<Drinks?> onChanged;

  const DrinksDropdown({
    Key? key,
    required this.selectedDrink,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Drinks>(
      value: selectedDrink,
      items: Drinks.values.map((d) {
        return DropdownMenuItem(
          value: d,
          child: Text(d.label),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
