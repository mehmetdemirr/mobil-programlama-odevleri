class Customer {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String company;
  final String status;
  final DateTime createdAt;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.status,
    required this.createdAt,
  });
}
