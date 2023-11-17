// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_presenter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginPresenterStore on _LoginPresenterStoreBase, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_LoginPresenterStoreBase.isFormValid'))
          .value;
  Computed<bool>? _$isEmailValidComputed;

  @override
  bool get isEmailValid =>
      (_$isEmailValidComputed ??= Computed<bool>(() => super.isEmailValid,
              name: '_LoginPresenterStoreBase.isEmailValid'))
          .value;
  Computed<bool>? _$isPasswordValidComputed;

  @override
  bool get isPasswordValid =>
      (_$isPasswordValidComputed ??= Computed<bool>(() => super.isPasswordValid,
              name: '_LoginPresenterStoreBase.isPasswordValid'))
          .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_LoginPresenterStoreBase.hasError'))
          .value;
  Computed<bool>? _$redirectPageComputed;

  @override
  bool get redirectPage =>
      (_$redirectPageComputed ??= Computed<bool>(() => super.redirectPage,
              name: '_LoginPresenterStoreBase.redirectPage'))
          .value;
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin =>
      (_$canLoginComputed ??= Computed<bool>(() => super.canLogin,
              name: '_LoginPresenterStoreBase.canLogin'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_LoginPresenterStoreBase.isLoading', context: context);

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

  late final _$errorAtom =
      Atom(name: '_LoginPresenterStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$redirectAtom =
      Atom(name: '_LoginPresenterStoreBase.redirect', context: context);

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

  late final _$emailAtom =
      Atom(name: '_LoginPresenterStoreBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginPresenterStoreBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$isPasswordVisibleAtom = Atom(
      name: '_LoginPresenterStoreBase.isPasswordVisible', context: context);

  @override
  bool get isPasswordVisible {
    _$isPasswordVisibleAtom.reportRead();
    return super.isPasswordVisible;
  }

  @override
  set isPasswordVisible(bool value) {
    _$isPasswordVisibleAtom.reportWrite(value, super.isPasswordVisible, () {
      super.isPasswordVisible = value;
    });
  }

  late final _$authAsyncAction =
      AsyncAction('_LoginPresenterStoreBase.auth', context: context);

  @override
  Future<void> auth() {
    return _$authAsyncAction.run(() => super.auth());
  }

  late final _$goPrivacyPolicyAsyncAction =
      AsyncAction('_LoginPresenterStoreBase.goPrivacyPolicy', context: context);

  @override
  Future<void> goPrivacyPolicy() {
    return _$goPrivacyPolicyAsyncAction.run(() => super.goPrivacyPolicy());
  }

  late final _$_LoginPresenterStoreBaseActionController =
      ActionController(name: '_LoginPresenterStoreBase', context: context);

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$_LoginPresenterStoreBaseActionController.startAction(
        name: '_LoginPresenterStoreBase.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$_LoginPresenterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorNull() {
    final _$actionInfo = _$_LoginPresenterStoreBaseActionController.startAction(
        name: '_LoginPresenterStoreBase.setErrorNull');
    try {
      return super.setErrorNull();
    } finally {
      _$_LoginPresenterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_LoginPresenterStoreBaseActionController.startAction(
        name: '_LoginPresenterStoreBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginPresenterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginPresenterStoreBaseActionController.startAction(
        name: '_LoginPresenterStoreBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginPresenterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_LoginPresenterStoreBaseActionController.startAction(
        name: '_LoginPresenterStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_LoginPresenterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error},
redirect: ${redirect},
email: ${email},
password: ${password},
isPasswordVisible: ${isPasswordVisible},
isFormValid: ${isFormValid},
isEmailValid: ${isEmailValid},
isPasswordValid: ${isPasswordValid},
hasError: ${hasError},
redirectPage: ${redirectPage},
canLogin: ${canLogin}
    ''';
  }
}
