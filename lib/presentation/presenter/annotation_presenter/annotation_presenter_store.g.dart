// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation_presenter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnnotationPresenterStore on AnnotationPresenterStoreBase, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: 'AnnotationPresenterStoreBase.isFormValid'))
          .value;
  Computed<bool>? _$isUpdateTextValidComputed;

  @override
  bool get isUpdateTextValid => (_$isUpdateTextValidComputed ??= Computed<bool>(
          () => super.isUpdateTextValid,
          name: 'AnnotationPresenterStoreBase.isUpdateTextValid'))
      .value;

  late final _$textEditingControllerAtom = Atom(
      name: 'AnnotationPresenterStoreBase.textEditingController',
      context: context);

  @override
  TextEditingController get textEditingController {
    _$textEditingControllerAtom.reportRead();
    return super.textEditingController;
  }

  @override
  set textEditingController(TextEditingController value) {
    _$textEditingControllerAtom.reportWrite(value, super.textEditingController,
        () {
      super.textEditingController = value;
    });
  }

  late final _$updateTextAtom =
      Atom(name: 'AnnotationPresenterStoreBase.updateText', context: context);

  @override
  String get updateText {
    _$updateTextAtom.reportRead();
    return super.updateText;
  }

  @override
  set updateText(String value) {
    _$updateTextAtom.reportWrite(value, super.updateText, () {
      super.updateText = value;
    });
  }

  late final _$saveAnnotationAsyncAction = AsyncAction(
      'AnnotationPresenterStoreBase.saveAnnotation',
      context: context);

  @override
  Future<void> saveAnnotation() {
    return _$saveAnnotationAsyncAction.run(() => super.saveAnnotation());
  }

  late final _$deleteAnnotationByIdAsyncAction = AsyncAction(
      'AnnotationPresenterStoreBase.deleteAnnotationById',
      context: context);

  @override
  Future<void> deleteAnnotationById({required String id}) {
    return _$deleteAnnotationByIdAsyncAction
        .run(() => super.deleteAnnotationById(id: id));
  }

  late final _$updateAnnotationByIdAsyncAction = AsyncAction(
      'AnnotationPresenterStoreBase.updateAnnotationById',
      context: context);

  @override
  Future<void> updateAnnotationById(
      {required AnnotationModel annotationModel}) {
    return _$updateAnnotationByIdAsyncAction.run(
        () => super.updateAnnotationById(annotationModel: annotationModel));
  }

  late final _$AnnotationPresenterStoreBaseActionController =
      ActionController(name: 'AnnotationPresenterStoreBase', context: context);

  @override
  void setAnotationText(String value) {
    final _$actionInfo = _$AnnotationPresenterStoreBaseActionController
        .startAction(name: 'AnnotationPresenterStoreBase.setAnotationText');
    try {
      return super.setAnotationText(value);
    } finally {
      _$AnnotationPresenterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUpdateText(String value) {
    final _$actionInfo = _$AnnotationPresenterStoreBaseActionController
        .startAction(name: 'AnnotationPresenterStoreBase.setUpdateText');
    try {
      return super.setUpdateText(value);
    } finally {
      _$AnnotationPresenterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
textEditingController: ${textEditingController},
updateText: ${updateText},
isFormValid: ${isFormValid},
isUpdateTextValid: ${isUpdateTextValid}
    ''';
  }
}
