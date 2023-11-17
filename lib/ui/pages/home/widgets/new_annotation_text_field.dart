import 'package:flutter/material.dart';

import '../../../../presentation/presenter/annotation_presenter/annotation_presenter_store.dart';

class NewAnnotationTextField extends StatelessWidget {
  const NewAnnotationTextField({
    super.key,
    required this.annotationPresenterStore,
  });

  final AnnotationPresenterStore annotationPresenterStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        controller: annotationPresenterStore.textEditingController,
        minLines: 1,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Anotação',
          errorText: annotationPresenterStore.textEditingController.text.isEmpty
              ? 'Campo obrigatório'
              : null,
        ),
        onChanged: (value) => annotationPresenterStore.setAnotationText(value),
        onSubmitted: (value) {
          if (annotationPresenterStore.isFormValid) {
            annotationPresenterStore.saveAnnotation().then(
                (_) => annotationPresenterStore.textEditingController.clear());
          }
        },
        onTapOutside: (event) {
          annotationPresenterStore.textEditingController.clear();
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
