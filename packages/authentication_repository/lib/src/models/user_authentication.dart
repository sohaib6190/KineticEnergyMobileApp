part of 'models.dart';

class UserAuthentication extends Equatable {
  final User? user;
  final String? token;
  final String? refreshToken;

  const UserAuthentication({
    this.user,
    this.token,
    this.refreshToken,
  });

  static const empty = UserAuthentication(token: "");

  bool get isEmpty => this == UserAuthentication.empty;

  bool get isNotEmpty => this != UserAuthentication.empty;

  factory UserAuthentication.fromJson(Map<String, dynamic> json) =>
      UserAuthentication(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
        "refresh_token": refreshToken,
      };

  UserAuthentication copyWith({
    User? user,
    String? token,
    String? refreshToken,
  }) {
    return UserAuthentication(
      user: user ?? this.user,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  List<Object?> get props => [user, token, refreshToken];
}

class User extends Equatable {
  const User({
    this.id,
    this.name,
    this.email,
    this.username,
    this.type,
    this.dateofbirth,
    this.profilePic,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? username;
  final String? type;
  final String? dateofbirth;
  final String? profilePic;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        type: json["type"],
        dateofbirth: json["dateofbirth"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "type": type,
        "dateofbirth": dateofbirth,
        "profile_pic": profilePic,
      };

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? username,
    String? type,
    String? dateofbirth,
    String? profilePic,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      type: type ?? this.type,
      dateofbirth: dateofbirth ?? this.dateofbirth,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        username,
        type,
        dateofbirth,
        profilePic,
      ];
}
