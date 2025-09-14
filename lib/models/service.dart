import '../widgets/info_card.dart';

class Service implements CardData {
  final String name;
  final String description;
  final double price;

  const Service({
    required this.name,
    required this.description,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    final name = json['name']?.toString() ?? '';
    final description = json['description']?.toString() ?? '';
    final price = (json['price'] as num?)?.toDouble() ?? 0.0;

    if (name.isEmpty) {
      throw const FormatException('Service name is required');
    }
    if (description.isEmpty) {
      throw const FormatException('Service description is required');
    }
    if (price <= 0) {
      throw const FormatException('Service price must be greater than 0');
    }

    return Service(
      name: name,
      description: description,
      price: price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Service &&
        other.name == name &&
        other.description == description &&
        other.price == price;
  }

  @override
  int get hashCode {
    return name.hashCode ^ description.hashCode ^ price.hashCode;
  }

  @override
  String toString() {
    return 'Service(name: $name, description: $description, price: $price)';
  }

  @override
  String get title => name;

  @override
  String get subtitle => description;

  @override
  String get trailing => '\$${price.toStringAsFixed(2)}';
}
