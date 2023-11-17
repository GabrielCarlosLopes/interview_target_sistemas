// ignore_for_file: library_private_types_in_public_api

import 'package:interview_target_sistemas/data/usecases/usecases.dart';
import 'package:mobx/mobx.dart';
part 'splash_presenter_sotre.g.dart';

class SplashPresenterStore = _SplashPresenterStoreBase
    with _$SplashPresenterStore;

abstract class _SplashPresenterStoreBase with Store {
  LocalLoadCurrentAccount loadCurrentAccount;

  _SplashPresenterStoreBase({required this.loadCurrentAccount});

  @observable
  bool isLoading = false;

  @observable
  String? redirect;

  @action
  loggedIn() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));

    try {
      await loadCurrentAccount.load();

      redirect = '/home';
    } catch (e) {
      redirect = '/login';
    } finally {
      isLoading = false;
    }
  }

  @action
  void dispose() {
    isLoading = false;
    redirect = null;
  }
}
