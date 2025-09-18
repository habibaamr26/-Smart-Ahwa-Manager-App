


enum Drinks {
  shai,
  turkishCoffee,
  hibiscusTea,
  coffee,
  juice,
}

extension DrinksType on Drinks {
  String get label {
    switch (this) {
      case Drinks.shai:
        return 'shai';
      case Drinks.turkishCoffee:
        return 'turkishCoffee';
      case Drinks.hibiscusTea:
        return 'hibiscusTea';
      case Drinks.coffee:
        return 'coffee';
      case Drinks.juice:
        return 'Juice';
        default:
          return "water";
    }
  }
}

class Order {
  late final int _id;
  late String _customerName;
  late Drinks _drinkType;
  late String? _instructions; ///
  late bool _isCompleted;
  static  int numberOfOrders=0;
  late DateTime? _createdAt;
  Order( {
    required String customerName,
    required Drinks drinkType,
    String instructions = '',
    bool completed = false,
    DateTime? createdAt,
  }) {
    _customerName = customerName;
    _drinkType = drinkType; // use enum here
    _instructions = instructions;
    _isCompleted = completed;
    _createdAt=createdAt;
    numberOfOrders++;
    _id=numberOfOrders;
  }

  // Getters
  int get id => _id;
  String get customerName => _customerName;
  DateTime? get createdAt => _createdAt;
  String? get instructions => _instructions;
  String get drinkType => _drinkType.label;
  String? get notes => _instructions;
  bool get isCompleted => _isCompleted;

  // Methods
  void markCompleted() {
    _isCompleted = true;
  }
}


