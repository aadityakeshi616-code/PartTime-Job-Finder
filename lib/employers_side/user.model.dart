class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String mobile;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.mobile,
  });

  // Map → Object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
      mobile: map['mobile'],
    );
  }

  // Object → Map (DB insert ke liye)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'mobile': mobile,
    };
  }
}