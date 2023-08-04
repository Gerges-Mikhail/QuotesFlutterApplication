class UserModel {
  late String name;
  late String email;
  late String password;
  late String phone;
  late String age;
  late String gender;
  late String id;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
   required this.id,
    required this.age,
    required this.gender,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    id = json['id'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'id': id,
      'age': age,
      'gender': gender,
    };
  }
}
