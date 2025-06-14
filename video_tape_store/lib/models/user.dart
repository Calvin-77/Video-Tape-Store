class User {
  int UserID;
  String Username;
  String Password;
  String Email;
  String Role;
  String Token;

  User({
    required this.UserID,
    required this.Username,
    required this.Password,
    required this.Email,
    required this.Role,
    required this.Token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      UserID: json["UserID"] as int,
      Username: json["Username"].toString(),
      Password: json["Password"].toString(),
      Email: json["Email"].toString(),
      Role: json["Role"].toString(),
      Token: json["Token"].toString());
}
