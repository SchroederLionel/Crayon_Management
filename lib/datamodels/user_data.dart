class UserData {
  final String path = 'users';

  String uid;
  String email;
  String firstName;
  String lastName;

  UserData(
      {required this.uid,
      required this.email,
      required this.firstName,
      required this.lastName});

  UserData.fromJson(Map<String, dynamic>? json)
      : uid = json!['uid'],
        email = json['email'],
        firstName = json['firstName'],
        lastName = json['lastName'];

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
      };
}
