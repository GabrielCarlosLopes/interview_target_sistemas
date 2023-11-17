import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interview_target_sistemas/data/data.dart';
import 'package:interview_target_sistemas/presentation/presenter/splash_presenter/splash_presenter_sotre.dart';
import 'package:mocktail/mocktail.dart';

class LocalLoadCurrentAccountMock extends Mock
    implements LocalLoadCurrentAccount {}

void main() {
  late SplashPresenterStore sut;
  late LocalLoadCurrentAccountMock loadCurrentAccountMock;

  setUp(() {
    loadCurrentAccountMock = LocalLoadCurrentAccountMock();
    sut = SplashPresenterStore(loadCurrentAccount: loadCurrentAccountMock);
  });

  test('should initialize with correct values', () {
    expect(sut.isLoading, false);
    expect(sut.redirect, null);
  });

  group('loggedIn', () {
    test('should call loadCurrentAccount', () async {
      await sut.loggedIn();

      verify(() => loadCurrentAccountMock.load()).called(1);
    });

    test('should set redirect to /home if load succeeds', () async {
      when(() => loadCurrentAccountMock.load())
          .thenAnswer((_) async => UserModel(
                id: faker.randomGenerator.integer(9999).toString(),
                name: faker.person.name(),
                email: faker.internet.email(),
                avatar: faker.internet.httpUrl(),
                createdAt: faker.date.dateTime().toString(),
                password: faker.internet.password(),
              ).toEntity());

      await sut.loggedIn();

      expect(sut.redirect, '/home');
    });

    test('should set redirect to /login if load throws', () async {
      when(() => loadCurrentAccountMock.load()).thenThrow(Exception());

      await sut.loggedIn();

      expect(sut.redirect, '/login');
    });

    test('should set isLoading to false after loadCurrentAccount', () async {
      await sut.loggedIn();

      expect(sut.isLoading, false);
    });

    test('should set isLoading to false if loadCurrentAccount throws',
        () async {
      when(() => loadCurrentAccountMock.load()).thenThrow(Exception());

      await sut.loggedIn();

      expect(sut.isLoading, false);
    });

    test('should set isLoading to true before calls loggedIn', () async {
      sut.loggedIn();
      expect(sut.isLoading, true);
    });
  });

  group('dispose', () {
    test('should set isLoading to false and redirect to null', () {
      sut.dispose();

      expect(sut.isLoading, false);
      expect(sut.redirect, null);
    });
  });
}
