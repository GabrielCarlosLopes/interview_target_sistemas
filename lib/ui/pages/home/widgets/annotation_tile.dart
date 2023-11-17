import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_target_sistemas/data/models/models.dart';

import '../../../../presentation/presenter/annotation_presenter/annotation_presenter_store.dart';

class AnnotationTile extends StatefulWidget {
  const AnnotationTile({
    super.key,
    required this.item,
    required this.annotationPresenterStore,
  });

  final AnnotationModel item;
  final AnnotationPresenterStore annotationPresenterStore;

  @override
  State<AnnotationTile> createState() => _AnnotationTileState();
}

class _AnnotationTileState extends State<AnnotationTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.item.annotation),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      widget.annotationPresenterStore
                          .setUpdateText(widget.item.annotation);
                      return AlertDialog.adaptive(
                        title: const Text('Editar anotação'),
                        content: adaptativeTextField(
                          widget.item.annotation,
                          (value) => widget.annotationPresenterStore
                              .setUpdateText(value),
                          context: context,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          Observer(builder: (context) {
                            return TextButton(
                              onPressed: widget.annotationPresenterStore
                                      .isUpdateTextValid
                                  ? () {
                                      widget.annotationPresenterStore
                                          .updateAnnotationById(
                                        annotationModel: AnnotationModel(
                                          id: widget.item.id,
                                          annotation: widget
                                              .annotationPresenterStore
                                              .updateText,
                                        ),
                                      );
                                      context.pop(context);
                                    }
                                  : null,
                              child: const Text('Salvar'),
                            );
                          }),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () async => await widget.annotationPresenterStore
                    .deleteAnnotationById(id: widget.item.id),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget adaptativeTextField(String inialValue, Function(String) onChanged,
    {required BuildContext context}) {
  return Platform.isAndroid
      ? TextFormField(
          autofocus: true,
          initialValue: inialValue,
          onChanged: (value) => onChanged(value),
          decoration: const InputDecoration(
            hintText: 'Digite sua anotação',
            border: OutlineInputBorder(),
          ),
        )
      : CupertinoTextFormFieldRow(
          initialValue: inialValue,
          autofocus: true,
          onChanged: (value) => onChanged(value),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        );
}
