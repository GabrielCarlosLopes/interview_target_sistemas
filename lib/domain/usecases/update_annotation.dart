import 'package:interview_target_sistemas/domain/entities/annotation_entity.dart';

abstract class UpdateAnnotation {
  Future<bool> update(AnnotationEntity annotationEntity);
}
