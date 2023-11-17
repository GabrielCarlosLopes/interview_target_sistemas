import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:interview_target_sistemas/data/cache/cache.dart';
import 'package:interview_target_sistemas/data/usecases/load_annotations/local_load_annotations.dart';
import 'package:interview_target_sistemas/domain/entities/entities.dart';
import 'package:interview_target_sistemas/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class LocalDataSourceSpy extends Mock implements LocalDataSource {}

void main() {
  late LocalLoadAnnotations sut;
  late LocalDataSourceSpy localDataSource;

  void mockLoadData(List<dynamic> data) {
    when(() => localDataSource.getData(key: any(named: 'key')))
        .thenAnswer((_) async => jsonEncode(data));
  }

  void mockLoadDataError() {
    when(() => localDataSource.getData(key: any(named: 'key')))
        .thenThrow(Exception());
  }

  setUp(() {
    localDataSource = LocalDataSourceSpy();
    sut = LocalLoadAnnotations(localDataSource: localDataSource);
    mockLoadData([]);
  });

  test('should call LocalDataSource with correct key', () async {
    await sut.load();

    verify(() => localDataSource.getData(key: 'annotations')).called(1);
  });

  test('should return a list of AnnotationEntity on success', () async {
    final data = [
      {
        'id': faker.guid.guid(),
        'annotation': faker.lorem.sentence(),
      },
      {
        'id': faker.guid.guid(),
        'annotation': faker.lorem.sentence(),
      }
    ];
    final dataEncode = [
      jsonEncode({
        'id': data[0]['id'],
        'annotation': data[0]['annotation'],
      }),
      jsonEncode({
        'id': data[1]['id'],
        'annotation': data[1]['annotation'],
      })
    ];

    mockLoadData(dataEncode);

    final result = await sut.load();

    expect(result, [
      AnnotationEntity(
        id: data[0]['id']!,
        annotation: data[0]['annotation']!,
      ),
      AnnotationEntity(
        id: data[1]['id']!,
        annotation: data[1]['annotation']!,
      ),
    ]);
  });

  test('should return an empty list if there is no data', () async {
    mockLoadData([]);

    final result = await sut.load();

    expect(result, []);
  });

  test('should throw if LocalDataSource throws', () async {
    mockLoadDataError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
