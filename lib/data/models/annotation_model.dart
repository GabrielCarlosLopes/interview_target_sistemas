import 'dart:convert';

import 'package:interview_target_sistemas/domain/entities/entities.dart';
import 'package:interview_target_sistemas/domain/helpers/helpers.dart';

class AnnotationModel {
  final String id;
  final String annotation;

  AnnotationModel({
    required this.id,
    required this.annotation,
  });

  factory AnnotationModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'annotation'])) {
      throw DomainError.unexpected;
    }
    return AnnotationModel(
      id: json['id'],
      annotation: json['annotation'],
    );
  }

  String toJson() => jsonEncode({
        'id': id,
        'annotation': annotation,
      });

  AnnotationEntity toEntity() => AnnotationEntity(
        id: id,
        annotation: annotation,
      );

  factory AnnotationModel.fromEntity(AnnotationEntity entity) {
    return AnnotationModel(
      id: entity.id,
      annotation: entity.annotation,
    );
  }
}
