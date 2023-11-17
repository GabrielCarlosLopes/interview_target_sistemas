import 'package:interview_target_sistemas/data/usecases/usecases.dart';
import 'package:interview_target_sistemas/domain/helpers/helpers.dart';
import 'package:interview_target_sistemas/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

import 'package:interview_target_sistemas/data/http/http.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;
  late AuthenticationParams params;

  mockRequest() => when(
        () => httpClient.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        ),
      );

  void mockHttpData(List<Map> data) {
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = 'http://any_url.com';
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = const AuthenticationParams(
      email: 'any_email@mail.com',
      secret: 'any_password',
    );
    mockHttpData([
      {
        "createdAt": "2023-11-13T14:32:20.296Z",
        "name": "Jon Towne",
        "avatar":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/483.jpg",
        "email": "any_email",
        "password": "any_password",
        "id": '1'
      }
    ]);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.auth(params);

    verify(
      () => httpClient.request(
        url: '$url?email=${params.email}',
        method: 'get',
      ),
    ).called(1);
  });

  test('Should return an User if HttpClient returns 200', () async {
    const String id = '1';
    mockHttpData([
      {
        "createdAt": "2023-11-13T14:32:20.296Z",
        "name": "Jon Towne",
        "avatar":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/483.jpg",
        "email": "any_email",
        "password": "any_password",
        "id": id
      }
    ]);

    final user = await sut.auth(params);

    expect(user.id, id);
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401',
      () async {
    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
