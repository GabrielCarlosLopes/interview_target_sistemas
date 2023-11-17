import 'package:interview_target_sistemas/infra/cache/cache.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  late LocalDataSourceAdapter sut;
  late SharedPreferencesMock sharedPreferencesMock;

  setUp(() {
    sharedPreferencesMock = SharedPreferencesMock();
    sut = LocalDataSourceAdapter(sharedPreferencesMock);
  });

  group('saveData', () {
    test('should call SharedPreferences with correct values', () async {
      const key = 'any_key';
      const value = 'any_value';

      when(() => sharedPreferencesMock.setString(key, value))
          .thenAnswer((_) async => true);

      await sut.saveData(key: key, value: value);

      verify(() => sharedPreferencesMock.setString(key, value)).called(1);
    });

    test('should return true on success', () async {
      const key = 'any_key';
      const value = 'any_value';

      when(() => sharedPreferencesMock.setString(key, value))
          .thenAnswer((_) async => true);

      final result = await sut.saveData(key: key, value: value);

      expect(result, true);
    });

    test('should throw if SharedPreferences throws', () async {
      const key = 'any_key';
      const value = 'any_value';

      when(() => sharedPreferencesMock.setString(key, value))
          .thenThrow(Exception());

      final future = sut.saveData(key: key, value: value);

      expect(future, throwsA(isA<Exception>()));
    });
  });

  group('getData', () {
    test('should call SharedPreferences with correct values', () async {
      const key = 'any_key';

      when(() => sharedPreferencesMock.getString(key)).thenAnswer((_) => null);

      await sut.getData(key: key);

      verify(() => sharedPreferencesMock.getString(key)).called(1);
    });

    test('should return correct value on success', () async {
      const key = 'any_key';
      const value = 'any_value';

      when(() => sharedPreferencesMock.getString(key)).thenAnswer((_) => value);

      final result = await sut.getData(key: key);

      expect(result, value);
    });

    test('should throw if SharedPreferences throws', () async {
      const key = 'any_key';

      when(() => sharedPreferencesMock.getString(key)).thenThrow(Exception());

      final future = sut.getData(key: key);

      expect(future, throwsA(isA<Exception>()));
    });
  });

  group('deleteData', () {
    test('should call SharedPreferences with correct values', () async {
      const key = 'any_key';

      when(() => sharedPreferencesMock.remove(key))
          .thenAnswer((_) async => true);

      await sut.deleteData(key: key);

      verify(() => sharedPreferencesMock.remove(key)).called(1);
    });

    test('should return true on success', () async {
      const key = 'any_key';

      when(() => sharedPreferencesMock.remove(key))
          .thenAnswer((_) async => true);

      final result = await sut.deleteData(key: key);

      expect(result, true);
    });

    test('should throw if SharedPreferences throws', () async {
      const key = 'any_key';

      when(() => sharedPreferencesMock.remove(key)).thenThrow(Exception());

      final future = sut.deleteData(key: key);

      expect(future, throwsA(isA<Exception>()));
    });
  });
}
