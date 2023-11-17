import 'package:equatable/equatable.dart';

class AnnotationEntity extends Equatable {
  final String id;
  final String annotation;

  const AnnotationEntity({required this.id, required this.annotation});

  @override
  List get props => [id, annotation];
}
