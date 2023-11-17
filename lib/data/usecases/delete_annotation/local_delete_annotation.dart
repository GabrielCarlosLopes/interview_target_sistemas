import 'dart:convert';

import 'package:interview_target_sistemas/data/cache/cache.dart';
import 'package:interview_target_sistemas/domain/usecases/usecases.dart';

import '../../models/models.dart';

class LocalDeleteAnnotation implements DeleteAnnotation {
  final LocalDataSource localDataSource;

  LocalDeleteAnnotation({required this.localDataSource});

  @override
  Future<bool> delete(String id) async {
    try {
      final data = await localDataSource.getData(key: 'annotations');

      if (data != null) {
        final list = (jsonDecode(data) as List)
            .map((e) => AnnotationModel.fromJson(jsonDecode(e)))
            .toList();

        list.removeWhere((element) => element.id == id);

        return await localDataSource.saveData(
          key: 'annotations',
          value: jsonEncode(
              list.map((annotation) => annotation.toJson()).toList()),
        );
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
