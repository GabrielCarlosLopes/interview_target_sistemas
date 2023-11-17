// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_presenter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePresenterStore on _HomePresenterStoreBase, Store {
  late final _$randomStreamAtom =
      Atom(name: '_HomePresenterStoreBase.randomStream', context: context);

  @override
  ObservableStream<List<AnnotationModel>> get randomStream {
    _$randomStreamAtom.reportRead();
    return super.randomStream;
  }

  @override
  set randomStream(ObservableStream<List<AnnotationModel>> value) {
    _$randomStreamAtom.reportWrite(value, super.randomStream, () {
      super.randomStream = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_HomePresenterStoreBase.error', context: context);

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

  late final _$logOutAsyncAction =
      AsyncAction('_HomePresenterStoreBase.logOut', context: context);

  @override
  Future<bool> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  @override
  String toString() {
    return '''
randomStream: ${randomStream},
error: ${error}
    ''';
  }
}
