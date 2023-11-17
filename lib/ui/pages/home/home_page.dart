import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_target_sistemas/presentation/presenter/annotation_presenter/annotation_presenter_store.dart';
import 'package:interview_target_sistemas/presentation/presenter/home_presenter/home_presenter_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePresenterStore presenter;
  final AnnotationPresenterStore annotationPresenterStore =
      GetIt.I<AnnotationPresenterStore>();

  @override
  void initState() {
    presenter = GetIt.I<HomePresenterStore>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações'),
        actions: [
          IconButton(
            onPressed: () async => GetIt.I<SharedPreferences>().clear().then(
                (value) => value ? context.pushReplacement('/login') : null),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: presenter.randomStream,
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data!.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const NoAnnotationsMessage(),
                    NewAnnotationTextField(
                        annotationPresenterStore: annotationPresenterStore)
                  ],
                );
              }

              if (snapshot.data != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListAnnotations(
                      annotationPresenterStore: annotationPresenterStore,
                      listAnnotations: snapshot.data!,
                    ),
                    const SizedBox(height: 12),
                    NewAnnotationTextField(
                        annotationPresenterStore: annotationPresenterStore)
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }
}
