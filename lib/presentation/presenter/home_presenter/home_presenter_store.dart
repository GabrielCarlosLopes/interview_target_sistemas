// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:interview_target_sistemas/data/data.dart';
import 'package:interview_target_sistemas/infra/cache/cache.dart';
import 'package:mobx/mobx.dart';
part 'home_presenter_store.g.dart';

class HomePresenterStore = _HomePresenterStoreBase with _$HomePresenterStore;

abstract class _HomePresenterStoreBase with Store {
  final LocalLoadAnnotations localLoadAnnotations;
  final LocalDataSourceAdapter localDataSourceAdapter;

  _HomePresenterStoreBase(
      {required this.localLoadAnnotations,
      required this.localDataSourceAdapter}) {
    _streamController = StreamController<List<AnnotationModel>>();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => loadAnnotations(),
    );

    randomStream =
        ObservableStream(_streamController.stream.asBroadcastStream());
  }

  late final Timer _timer;

  late final StreamController<List<AnnotationModel>> _streamController;

  @observable
  late ObservableStream<List<AnnotationModel>> randomStream =
      ObservableStream<List<AnnotationModel>>(_streamController.stream);

  @observable
  String? error;

  @action
  Future<bool> logOut() async {
    try {
      await localDataSourceAdapter.sharedPreferences.clear();
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    }
  }

  void loadAnnotations() async {
    try {
      final annotations = await localLoadAnnotations.load();
      _streamController
          .add(annotations.map((e) => AnnotationModel.fromEntity(e)).toList());
    } catch (e) {
      error = e.toString();
    }
  }

  void dispose() async {
    error = null;
    _timer.cancel();
    await _streamController.close();
  }
}
