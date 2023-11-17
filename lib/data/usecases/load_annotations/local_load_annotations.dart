import 'dart:convert';

import 'package:interview_target_sistemas/data/cache/cache.dart';
import 'package:interview_target_sistemas/domain/entities/entities.dart';
import 'package:interview_target_sistemas/domain/usecases/load_annotations.dart';

import '../../../domain/helpers/helpers.dart';
import '../../models/models.dart';

class LocalLoadAnnotations implements LoadAnnotations {
  final LocalDataSource localDataSource;

  LocalLoadAnnotations({required this.localDataSource});

  @override
  Future<List<AnnotationEntity>> load() async {
    try {
      final data = await localDataSource.getData(key: 'annotations');

      if (data != null) {
        return (jsonDecode(data) as List)
            .map((e) => AnnotationModel.fromJson(jsonDecode(e)).toEntity())
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
