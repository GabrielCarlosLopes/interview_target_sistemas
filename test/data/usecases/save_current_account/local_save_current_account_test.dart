import 'package:faker/faker.dart';
import 'package:interview_target_sistemas/data/data.dart';
import 'package:interview_target_sistemas/domain/entities/entities.dart';
import 'package:interview_target_sistemas/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class LocalDataSourceMock extends Mock implements LocalDataSource {}

void main() {
  late LocalSaveCurrentAccount sut;
  late LocalDataSourceMock localDataSourceMock;
  late UserEntity user;

  setUp(() {
    localDataSourceMock = LocalDataSourceMock();
    sut = LocalSaveCurrentAccount(localDataSource: localDataSourceMock);
    user = UserEntity(
      name: faker.person.name(),
      email: faker.internet.email(),
      password: faker.internet.password(),
      avatar: faker.image.image(),
      createdAt: faker.date.dateTime().toString(),
      id: faker.guid.guid(),
    );
  });

  test('should call LocalDataSource with correct values', () async {
    when(() => localDataSourceMock.saveData(
          key: 'account',
          value: UserModel.fromEntity(user).toJson(),
        )).thenAnswer((_) async => true);

    await sut.save(user);

    verify(() => localDataSourceMock.saveData(
          key: 'account',
          value: UserModel.fromEntity(user).toJson(),
        )).called(1);
  });

  test('should return true on success', () async {
    when(() => localDataSourceMock.saveData(
          key: 'account',
          value: UserModel.fromEntity(user).toJson(),
        )).thenAnswer((_) async => true);

    final result = await sut.save(user);

    expect(result, true);
  });

  test('should throw unexpected error if LocalDataSource throws', () async {
    when(() => localDataSourceMock.saveData(
          key: 'account',
          value: UserModel.fromEntity(user).toJson(),
        )).thenThrow(Exception());

    final future = sut.save(user);

    expect(future, throwsA(DomainError.unexpected));
  });
}
