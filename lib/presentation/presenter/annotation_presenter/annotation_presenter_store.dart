import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interview_target_sistemas/data/data.dart';
import 'package:interview_target_sistemas/data/usecases/delete_annotation/local_delete_annotation.dart';
import 'package:interview_target_sistemas/data/usecases/update_annotation/update_annotation.dart';
import 'package:interview_target_sistemas/domain/entities/entities.dart';
import 'package:interview_target_sistemas/domain/helpers/helpers.dart';
import 'package:mobx/mobx.dart';
part 'annotation_presenter_store.g.dart';

class AnnotationPresenterStore = AnnotationPresenterStoreBase
    with _$AnnotationPresenterStore;

abstract class AnnotationPresenterStoreBase with Store {
  final LocalSaveAnnotation localSaveAnnotation;
  final LocalDeleteAnnotation deleteAnnotation;
  final LocalUpdateAnnotation updateAnnotation;

  AnnotationPresenterStoreBase({
    required this.localSaveAnnotation,
    required this.deleteAnnotation,
    required this.updateAnnotation,
  });

  @observable
  TextEditingController textEditingController = TextEditingController();

  @observable
  String updateText = '';

  @computed
  bool get isFormValid => textEditingController.text.isNotEmpty;

  @computed
  bool get isUpdateTextValid => updateText.isNotEmpty;

  @action
  void setAnotationText(String value) => textEditingController.text = value;

  @action
  void setUpdateText(String value) => updateText = value;

  @action
  Future<void> saveAnnotation() async {
    try {
      final annotationEntity = AnnotationEntity(
          id: Random().nextInt(20000).toString(),
          annotation: textEditingController.text);

      await localSaveAnnotation.save(annotationEntity);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }

  @action
  Future<void> deleteAnnotationById({required String id}) async {
    try {
      await deleteAnnotation.delete(id);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }

  @action
  Future<void> updateAnnotationById(
      {required AnnotationModel annotationModel}) async {
    try {
      final annotationEntity = annotationModel.toEntity();

      final resp = await updateAnnotation.update(annotationEntity);

      if (resp == true) {
        setUpdateText('');
      }
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
