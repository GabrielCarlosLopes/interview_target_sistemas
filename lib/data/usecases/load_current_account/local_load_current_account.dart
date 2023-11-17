import 'dart:convert';
import 'dart:developer';

import 'package:interview_target_sistemas/data/data.dart';
import 'package:interview_target_sistemas/domain/entities/user_entity.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final LocalDataSource localDataSource;

  LocalLoadCurrentAccount({required this.localDataSource});

  @override
  Future<UserEntity> load() async {
    try {
      String? jsonString = await localDataSource.getData(key: 'account');
      log(jsonString ?? '');
      if (jsonString?.isNotEmpty == true) {
        return UserModel.fromJson(jsonDecode(jsonString!)).toEntity();
      } else {
        throw DomainError.unexpected;
      }
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
