// ignore_for_file: library_private_types_in_public_api
import 'package:interview_target_sistemas/data/usecases/usecases.dart';
import 'package:interview_target_sistemas/domain/entities/user_entity.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
part 'login_presenter_store.g.dart';

class LoginPresenterStore = _LoginPresenterStoreBase with _$LoginPresenterStore;

abstract class _LoginPresenterStoreBase with Store {
  final RemoteAuthentication remoteAuthentication;
  final LocalSaveCurrentAccount saveCurrentAccount;

  _LoginPresenterStoreBase({
    required this.remoteAuthentication,
    required this.saveCurrentAccount,
  });

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  String? redirect;

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool isPasswordVisible = false;

  @computed
  bool get isFormValid => email.isNotEmpty && password.isNotEmpty && !isLoading;

  @computed
  bool get isEmailValid =>
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email) &&
      email.length > 2 &&
      !email.contains(' ');

  @computed
  bool get isPasswordValid =>
      password.isNotEmpty &&
      password.length > 2 &&
      RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password);

  @computed
  bool get hasError => error != null && isLoading == false;

  @computed
  bool get redirectPage => redirect != null;

  @computed
  bool get canLogin => isEmailValid && isPasswordValid;

  @action
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }

  @action
  void setErrorNull() {
    error = null;
  }

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  Future<void> auth() async {
    try {
      isLoading = true;
      error = null;
      UserEntity user = await remoteAuthentication.auth(
        AuthenticationParams(
          email: email,
          secret: password,
        ),
      );

      bool cacheSaveStatus = await saveCurrentAccount.save(user);

      if (cacheSaveStatus) {
        redirect = '/home';
      }
    } on DomainError catch (error) {
      this.error = error.name;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> goPrivacyPolicy() async {
    if (!await launchUrl(Uri.parse('https://google.com.br'))) {
      error = 'Erro ao iniciar o navegador!';
    }
  }

  @action
  void dispose() {
    isLoading = false;
    error = null;
    redirect = null;
    email = '';
    password = '';
    isPasswordVisible = false;
  }
}
