class UserModel {
  final String email;
  final String password;
  final String name;
  final DateTime? birthDate;
  final String gender;
  final String phone;
  final String type;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'birthDate': birthDate?.millisecondsSinceEpoch,
      'gender': gender,
      'phone': phone,
      'type': type,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '-',
      password: map['password'] ?? '-',
      name: map['name'] ?? '-',
      birthDate: map['birthDate'],
      gender: map['gender'] ?? '-',
      phone: map['phone'] ?? '-',
      type: map['type'] ?? '-',
    );
  }
}

enum UserType {
  agricultor(name: 'Agricultor'),
  apicultor(name: 'Apicultor');

  final String name;

  const UserType({required this.name});
}
