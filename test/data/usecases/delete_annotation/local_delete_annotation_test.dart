import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:interview_target_sistemas/data/data.dart';
import 'package:interview_target_sistemas/data/usecases/delete_annotation/local_delete_annotation.dart';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class LocalDataSourceSpy extends Mock implements LocalDataSource {}

void main() {
  late LocalDeleteAnnotation sut;
  late LocalDataSourceSpy localDataSource;

  setUp(() {
    localDataSource = LocalDataSourceSpy();
    sut = LocalDeleteAnnotation(localDataSource: localDataSource);
  });

  group('delete', () {
    test('should call LocalDataSource with correct key', () async {
      const id = 'any_id';

      when(() => localDataSource.getData(key: any(named: 'key'))).thenAnswer(
        (_) async => jsonEncode([
          AnnotationModel(id: id, annotation: faker.lorem.sentence()).toJson()
        ]),
      );

      when(() => localDataSource.saveData(
          key: any(named: 'key'),
          value: any(named: 'value'))).thenAnswer((_) async => true);

      await sut.delete(id);

      verify(() => localDataSource.getData(key: 'annotations')).called(1);
      verify(() => localDataSource.saveData(
          key: 'annotations', value: jsonEncode([]))).called(1);
    });

    test('should return true on success', () async {
      const id = 'any_id';

      when(() => localDataSource.getData(key: any(named: 'key'))).thenAnswer(
        (_) async => jsonEncode([
          AnnotationModel(id: id, annotation: faker.lorem.sentence()).toJson()
        ]),
      );

      when(() => localDataSource.saveData(
          key: any(named: 'key'),
          value: any(named: 'value'))).thenAnswer((_) async => true);

      final result = await sut.delete(id);

      expect(result, true);
    });

    test('should return false if data was not deleted', () async {
      const id = 'any_id';

      when(() => localDataSource.getData(key: any(named: 'key')))
          .thenAnswer((_) async => jsonEncode([
                {
                  'id': 'any_other_id',
                  'title': 'any_title',
                  'description': 'any_description'
                }
              ]));

      final result = await sut.delete(id);

      expect(result, false);
    });

    test('should return false if LocalDataSource throws', () async {
      const id = 'any_id';

      when(() => localDataSource.getData(key: any(named: 'key')))
          .thenThrow(Exception());

      final result = await sut.delete(id);

      expect(result, false);
    });
  });
}
