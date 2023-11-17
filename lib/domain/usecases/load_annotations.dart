import 'package:interview_target_sistemas/domain/entities/entities.dart';

abstract class LoadAnnotations {
  Future<List<AnnotationEntity>> load();
}
