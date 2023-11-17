import 'dart:convert';

import '../../../data/cache/cache.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../models/models.dart';

class LocalSaveAnnotation implements SaveAnnotation {
  final LocalDataSource localDataSource;

  LocalSaveAnnotation({required this.localDataSource});

  @override
  Future<bool> save(AnnotationEntity annotation) async {
    try {
      final data = await localDataSource.getData(key: 'annotations');

      if (data != null) {
        final list = (jsonDecode(data) as List)
            .map((e) => AnnotationModel.fromJson(jsonDecode(e)))
            .toList();

        if (list.any((element) => element.id == annotation.id)) {
          throw DomainError.alreadyExists;
        }

        list.add(AnnotationModel.fromEntity(annotation));

        return await localDataSource.saveData(
          key: 'annotations',
          value: jsonEncode(
              list.map((annotation) => annotation.toJson()).toList()),
        );
      } else {
        return await localDataSource.saveData(
          key: 'annotations',
          value: jsonEncode([AnnotationModel.fromEntity(annotation)]),
        );
      }
    } catch (error) {
      error == DomainError.alreadyExists
          ? throw DomainError.alreadyExists
          : throw DomainError.unexpected;
    }
  }
}
