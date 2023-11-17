// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_presenter_sotre.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SplashPresenterStore on _SplashPresenterStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_SplashPresenterStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$redirectAtom =
      Atom(name: '_SplashPresenterStoreBase.redirect', context: context);

  @override
  String? get redirect {
    _$redirectAtom.reportRead();
    return super.redirect;
  }

  @override
  set redirect(String? value) {
    _$redirectAtom.reportWrite(value, super.redirect, () {
      super.redirect = value;
    });
  }

  late final _$loggedInAsyncAction =
      AsyncAction('_SplashPresenterStoreBase.loggedIn', context: context);

  @override
  Future loggedIn() {
    return _$loggedInAsyncAction.run(() => super.loggedIn());
  }

  late final _$_SplashPresenterStoreBaseActionController =
      ActionController(name: '_SplashPresenterStoreBase', context: context);

  @override
  void dispose() {
    final _$actionInfo = _$_SplashPresenterStoreBaseActionController
        .startAction(name: '_SplashPresenterStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_SplashPresenterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
redirect: ${redirect}
    ''';
  }
}
