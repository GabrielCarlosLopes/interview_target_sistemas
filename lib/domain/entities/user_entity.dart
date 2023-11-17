import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;
  final String email;
  final String password;
  final String id;

  const UserEntity(
      {required this.createdAt,
      required this.name,
      required this.avatar,
      required this.email,
      required this.password,
      required this.id});

  @override
  List get props => [createdAt, name, avatar, email, password, id];
}
