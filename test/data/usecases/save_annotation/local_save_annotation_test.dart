import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:interview_target_sistemas/data/cache/cache.dart';
import 'package:interview_target_sistemas/data/models/annotation_model.dart';
import 'package:interview_target_sistemas/data/usecases/save_annotation/local_save_annotation.dart';
import 'package:interview_target_sistemas/domain/entities/annotation_entity.dart';
import 'package:interview_target_sistemas/domain/helpers/domain_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class LocalDataSourceMock extends Mock implements LocalDataSource {}

void main() {
  late LocalSaveAnnotation sut;
  late LocalDataSourceMock localDataSourceMock;
  late AnnotationEntity annotation;

  setUp(() {
    localDataSourceMock = LocalDataSourceMock();
    sut = LocalSaveAnnotation(localDataSource: localDataSourceMock);
    annotation = AnnotationEntity(
      id: faker.guid.guid(),
      annotation: faker.lorem.sentence(),
    );
  });

  test(
      'should call LocalDataSource with correct values when list dont have elements',
      () async {
    when(() => localDataSourceMock.getData(key: 'annotations'))
        .thenAnswer((_) async => null);

    when(() => localDataSourceMock.saveData(
          key: 'annotations',
          value: any(named: 'value'),
        )).thenAnswer((_) async => true);

    await sut.save(annotation);

    verify(() => localDataSourceMock.getData(key: 'annotations')).called(1);
    verify(() => localDataSourceMock.saveData(
          key: 'annotations',
          value: jsonEncode([AnnotationModel.fromEntity(annotation).toJson()]),
        )).called(1);
  });

  test(
      'should call LocalDataSource with correct values when list have others elements',
      () async {
    final anotherAnnotation = AnnotationEntity(
      id: faker.guid.guid(),
      annotation: faker.lorem.sentence(),
    );

    when(() => localDataSourceMock.getData(key: 'annotations')).thenAnswer(
        (_) async => jsonEncode(
            [AnnotationModel.fromEntity(anotherAnnotation).toJson()]));

    when(() => localDataSourceMock.saveData(
          key: 'annotations',
          value: any(named: 'value'),
        )).thenAnswer((_) async => true);

    await sut.save(annotation);

    verify(() => localDataSourceMock.getData(key: 'annotations')).called(1);
    verify(() => localDataSourceMock.saveData(
          key: 'annotations',
          value: jsonEncode([
            AnnotationModel.fromEntity(anotherAnnotation).toJson(),
            AnnotationModel.fromEntity(annotation).toJson()
          ]),
        )).called(1);
  });

  test('should throw already exists error if annotation already exists',
      () async {
    final list = [
      AnnotationModel.fromEntity(annotation),
    ];
    when(() => localDataSourceMock.getData(key: 'annotations')).thenAnswer(
        (_) async => jsonEncode(list.map((e) => e.toJson()).toList()));

    final future = sut.save(annotation);

    expect(future, throwsA(DomainError.alreadyExists));
  });

  test('should throw unexpected error if LocalDataSource throws', () async {
    when(() => localDataSourceMock.getData(key: 'annotations'))
        .thenThrow(Exception());

    final future = sut.save(annotation);

    expect(future, throwsA(DomainError.unexpected));
  });
}
