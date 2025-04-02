class Person {
  final int id;
  final String name;
  final int age;
  final String surname;
  final String tc;
  final String address;
  final String phone;
  final String email;
  final DateTime birthDate;
  final String gender;
  final String maritalStatus;
  final String profession;
  final String city;
  final String country;
  final String postalCode;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Person({
    required this.id,
    required this.name,
    required this.age,
    required this.surname,
    required this.tc,
    required this.address,
    required this.phone,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.maritalStatus,
    required this.profession,
    required this.city,
    required this.country,
    required this.postalCode,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      surname: json['surname'],
      tc: json['tc'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      birthDate: DateTime.parse(json['birth_date']),
      gender: json['gender'],
      maritalStatus: json['marital_status'],
      profession: json['profession'],
      city: json['city'],
      country: json['country'],
      postalCode: json['postal_code'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
