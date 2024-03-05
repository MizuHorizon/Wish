import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final userModelProvider = StateProvider<MyAppUser?>((ref) => null);

class MyAppUser {
  final String id;
  final String name;
  final String username;
  final String profilePic;
  final String email;
  final String? fcmToken;
  MyAppUser({
    required this.id,
    required this.name,
    required this.username,
    required this.profilePic,
    required this.email,
    required this.fcmToken,
  });

  MyAppUser copyWith({
    String? id,
    String? name,
    String? username,
    String? profilePic,
    String? email,
    String? fcmToken,
  }) {
    return MyAppUser(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        profilePic: profilePic ?? this.profilePic,
        email: email ?? this.email,
        fcmToken: fcmToken ?? this.fcmToken);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'profile_pic': profilePic,
      'email': email,
      "fcmToken": fcmToken
    };
  }

  factory MyAppUser.fromMap(Map<String, dynamic> map) {
    return MyAppUser(
        id: map['id'] as String,
        name: map['name'] as String,
        username: map['username'] as String,
        profilePic: map['profile_pic'] as String,
        email: map['email'] as String,
        fcmToken: map['fcm_token'] ?? "null");
  }

  String toJson() => json.encode(toMap());

  factory MyAppUser.fromJson(String source) =>
      MyAppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, username: $username, profilePic: $profilePic, email: $email, fcmToken : $fcmToken)';
  }

  @override
  bool operator ==(covariant MyAppUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.username == username &&
        other.profilePic == profilePic &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        username.hashCode ^
        profilePic.hashCode ^
        email.hashCode;
  }
}
