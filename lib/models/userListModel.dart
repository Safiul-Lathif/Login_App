class UserList {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  UserList({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      id: json["id"]?.toString(),
      email: json["email"]?.toString(),
      firstName: json["first_name"]?.toString(),
      lastName: json["last_name"]?.toString(),
      avatar: json["avatar" + '1']?.toString(),
    );
  }
}
