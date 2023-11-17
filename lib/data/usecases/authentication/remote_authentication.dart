import '../../http/http.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../data/models/models.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  @override
  Future<UserEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final realUrl = '$url?email=${body['email']}';
      return await httpClient
          .request(url: realUrl, method: 'get')
          .then((httpResponse) {
        return httpResponse.isEmpty
            ? throw DomainError.invalidCredentials
            : httpResponse[0]['password'] == body['password']
                ? UserModel.fromJson(httpResponse[0]).toEntity()
                : throw DomainError.invalidCredentials;
      });
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({required this.email, required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJson() => {'email': email, 'password': password};
}
