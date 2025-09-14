import '../widgets/info_card.dart';

class Business implements CardData {
  final String name;
  final String location;
  final String contactNumber;

  const Business({
    required this.name,
    required this.location,
    required this.contactNumber,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    final name = json['biz_name']?.toString() ?? '';
    final location = json['bss_location']?.toString() ?? '';
    final contactNumber = json['contct_no']?.toString() ?? '';

    if (name.isEmpty) {
      throw const FormatException('Business name is required');
    }
    if (location.isEmpty) {
      throw const FormatException('Business location is required');
    }
    if (contactNumber.isEmpty) {
      throw const FormatException('Contact number is required');
    }

    return Business(
      name: name,
      location: location,
      contactNumber: contactNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'contactNumber': contactNumber,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Business &&
        other.name == name &&
        other.location == location &&
        other.contactNumber == contactNumber;
  }

  @override
  int get hashCode {
    return name.hashCode ^ location.hashCode ^ contactNumber.hashCode;
  }

  @override
  String toString() {
    return 'Business(name: $name, location: $location, contactNumber: $contactNumber)';
  }

  @override
  String get title => name;

  @override
  String get subtitle => location;

  @override
  String get trailing => contactNumber;
}
