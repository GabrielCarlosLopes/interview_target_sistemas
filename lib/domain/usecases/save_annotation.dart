import '../entities/entities.dart';

abstract class SaveAnnotation {
  Future<bool> save(AnnotationEntity annotation);
}
