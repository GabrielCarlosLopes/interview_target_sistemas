import 'dart:convert';

import 'package:interview_target_sistemas/data/cache/cache.dart';
import 'package:interview_target_sistemas/data/usecases/update_annotation/local_update_annotation.dart';
import 'package:interview_target_sistemas/domain/entities/entities.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class LocalDataSourceSpy extends Mock implements LocalDataSource {}

void main() {
  late LocalUpdateAnnotation sut;
  late LocalDataSourceSpy localDataSource;

  setUp(() {
    localDataSource = LocalDataSourceSpy();
    sut = LocalUpdateAnnotation(localDataSource: localDataSource);
  });

  test('should call LocalDataSource with correct key', () async {
    const entity = AnnotationEntity(
      id: '1',
      annotation: 'updated annotation',
    );
    final data = jsonEncode([
      {'id': '1', 'annotation': 'old annotation'},
    ]);
    when(() => localDataSource.getData(key: 'annotations'))
        .thenAnswer((_) async => data);

    await sut.update(entity);

    verify(() => localDataSource.getData(key: 'annotations')).called(1);
  });

  test('should return true if update is successful', () async {
    const entity = AnnotationEntity(
      id: '1',
      annotation: 'updated annotation',
    );
    final data = jsonEncode([
      jsonEncode({'id': '1', 'annotation': 'old annotation'}),
    ]);
    when(() => localDataSource.getData(key: 'annotations'))
        .thenAnswer((_) async => data);
    when(() => localDataSource.saveData(
          key: 'annotations',
          value: any(named: 'value'),
        )).thenAnswer((_) async => true);

    final result = await sut.update(entity);

    expect(result, true);
  });

  test('should return false if update fails', () async {
    const entity = AnnotationEntity(
      id: '1',
      annotation: 'updated annotation',
    );
    final data = jsonEncode([
      {'id': '1', 'annotation': 'old annotation'},
    ]);
    when(() => localDataSource.getData(key: 'annotations'))
        .thenAnswer((_) async => data);
    when(() => localDataSource.saveData(
          key: 'annotations',
          value: any(named: 'value'),
        )).thenAnswer((_) async => false);

    final result = await sut.update(entity);

    expect(result, false);
  });

  test('should return false if data is null', () async {
    const entity = AnnotationEntity(
      id: '1',
      annotation: 'updated annotation',
    );
    when(() => localDataSource.getData(key: 'annotations'))
        .thenAnswer((_) async => null);

    final result = await sut.update(entity);

    expect(result, false);
  });

  test('should return false if item is not found', () async {
    const entity = AnnotationEntity(
      id: '2',
      annotation: 'updated annotation',
    );
    final data = jsonEncode([
      {'id': '1', 'annotation': 'old annotation'},
    ]);
    when(() => localDataSource.getData(key: 'annotations'))
        .thenAnswer((_) async => data);

    final result = await sut.update(entity);

    expect(result, false);
  });

  test('should catch and return false if LocalDataSource throws', () async {
    const entity = AnnotationEntity(
      id: '1',
      annotation: 'updated annotation',
    );
    when(() => localDataSource.getData(key: 'annotations'))
        .thenThrow(Exception());

    final result = await sut.update(entity);

    expect(result, false);
  });
}
