import 'dart:convert';

import 'package:interview_target_sistemas/data/cache/cache.dart';
import 'package:interview_target_sistemas/domain/entities/entities.dart';

import '../../../domain/usecases/update_annotation.dart';
import '../../models/models.dart';

class LocalUpdateAnnotation implements UpdateAnnotation {
  final LocalDataSource localDataSource;

  LocalUpdateAnnotation({required this.localDataSource});

  @override
  Future<bool> update(AnnotationEntity entity) async {
    try {
      final data = await localDataSource.getData(key: 'annotations');
      final updateModel = AnnotationModel.fromEntity(entity);

      if (data != null) {
        final list = (jsonDecode(data) as List)
            .map((e) => AnnotationModel.fromJson(jsonDecode(e)))
            .toList();

        // Find the index of the item to update
        final index =
            list.indexWhere((annotation) => annotation.id == entity.id);

        if (index != -1) {
          // Update the item at the found index
          list[index] = updateModel;

          // Save the updated list
          return await localDataSource.saveData(
            key: 'annotations',
            value: jsonEncode(
                list.map((annotation) => annotation.toJson()).toList()),
          );
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
