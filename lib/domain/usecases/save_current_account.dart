import '../entities/entities.dart';

abstract class SaveCurrentAccount {
  Future<bool> save(UserEntity user);
}
