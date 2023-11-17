import 'package:interview_target_sistemas/data/data.dart';
import 'package:interview_target_sistemas/domain/entities/user_entity.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final LocalDataSource localDataSource;

  LocalSaveCurrentAccount({required this.localDataSource});

  @override
  Future<bool> save(UserEntity user) async {
    try {
      return await localDataSource.saveData(
        key: 'account',
        value: UserModel.fromEntity(user).toJson(),
      );
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
