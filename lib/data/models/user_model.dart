import 'dart:convert';

import 'package:interview_target_sistemas/domain/entities/entities.dart';

import '../http/http.dart';

class UserModel {
  final String createdAt;
  final String name;
  final String avatar;
  final String email;
  final String password;
  final String id;

  UserModel(
      {required this.createdAt,
      required this.name,
      required this.avatar,
      required this.email,
      required this.password,
      required this.id});

  factory UserModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id'])) {
      throw HttpError.invalidData;
    }

    return UserModel(
      createdAt: json['createdAt'],
      name: json['name'],
      avatar: json['avatar'],
      email: json['email'],
      password: json['password'],
      id: json['id'],
    );
  }

  String toJson() => jsonEncode({
        'createdAt': createdAt,
        'name': name,
        'avatar': avatar,
        'email': email,
        'password': password,
        'id': id,
      });

  UserEntity toEntity() => UserEntity(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
        email: email,
        password: password,
        id: id,
      );

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      createdAt: entity.createdAt,
      name: entity.name,
      avatar: entity.avatar,
      email: entity.email,
      password: entity.password,
      id: entity.id,
    );
  }
}
