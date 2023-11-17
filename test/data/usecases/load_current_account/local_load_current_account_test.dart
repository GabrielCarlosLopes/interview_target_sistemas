import 'package:faker/faker.dart';
import 'package:interview_target_sistemas/data/data.dart';
import 'package:interview_target_sistemas/domain/entities/entities.dart';
import 'package:interview_target_sistemas/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class LocalDataSourceSpy extends Mock implements LocalDataSource {}

void main() {
  late LocalLoadCurrentAccount sut;
  late LocalDataSourceSpy localDataSource;
  late String jsonString;
  late UserEntity user;
  late UserModel userModel;

  void mockLoadData(String? data) {
    when(() => localDataSource.getData(key: any(named: 'key')))
        .thenAnswer((_) async => data);
  }

  setUp(() {
    localDataSource = LocalDataSourceSpy();
    sut = LocalLoadCurrentAccount(localDataSource: localDataSource);

    userModel = UserModel(
      id: faker.randomGenerator.integer(9999).toString(),
      name: faker.person.name(),
      email: faker.internet.email(),
      avatar: faker.internet.httpUrl(),
      createdAt: faker.date.dateTime().toString(),
      password: faker.internet.password(),
    );
    user = userModel.toEntity();
    jsonString = userModel.toJson();
    mockLoadData(jsonString);
  });

  test('Should call LocalDataSource.getData with correct key', () async {
    await sut.load();

    verify(() => localDataSource.getData(key: 'account')).called(1);
  });

  test('Should return an UserEntity on success', () async {
    final result = await sut.load();

    expect(result, user);
  });

  test('Should throw UnexpectedError if LocalDataSource.getData throws',
      () async {
    when(() => localDataSource.getData(key: any(named: 'key')))
        .thenThrow(Exception());

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if LocalDataSource.getData returns null',
      () async {
    mockLoadData(null);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
