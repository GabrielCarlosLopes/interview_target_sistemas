import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';
import '../../../../presentation/presenter/annotation_presenter/annotation_presenter_store.dart';
import 'annotation_tile.dart';

class ListAnnotations extends StatelessWidget {
  const ListAnnotations({
    super.key,
    required this.annotationPresenterStore,
    required this.listAnnotations,
  });

  final AnnotationPresenterStore annotationPresenterStore;
  final List<AnnotationModel> listAnnotations;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listAnnotations.length,
        itemBuilder: (context, index) {
          final item = listAnnotations[index];

          return AnnotationTile(
            item: item,
            annotationPresenterStore: annotationPresenterStore,
          );
        },
      ),
    );
  }
}
