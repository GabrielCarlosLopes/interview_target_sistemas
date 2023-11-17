import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:interview_target_sistemas/data/data.dart';
import 'package:interview_target_sistemas/data/usecases/delete_annotation/local_delete_annotation.dart';
import 'package:interview_target_sistemas/data/usecases/update_annotation/update_annotation.dart';
import 'package:interview_target_sistemas/infra/cache/cache.dart';
import 'package:interview_target_sistemas/presentation/presenter/annotation_presenter/annotation_presenter_store.dart';
import 'package:interview_target_sistemas/presentation/presenter/login_presenter/login_presenter.dart';
import 'package:interview_target_sistemas/presentation/presenter/splash_presenter/splash_presenter_sotre.dart';
import 'package:interview_target_sistemas/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../infra/http/http.dart';
import '../presentation/presenter/home_presenter/home_presenter_store.dart';

final di = GetIt.I;

Future<void> initializeDependencies() async {
  //adapters
  di.registerSingleton<HttpAdapter>(HttpAdapter(Client()));

  final sharedPrefs = await SharedPreferences.getInstance();

  di.registerSingleton<SharedPreferences>(sharedPrefs);

  di.registerSingleton(LocalDataSourceAdapter(di<SharedPreferences>()));

  //useCases

  di.registerSingleton(
    RemoteAuthentication(httpClient: di<HttpAdapter>(), url: API.baseURL),
  );

  di.registerSingleton(
    LocalSaveCurrentAccount(localDataSource: di<LocalDataSourceAdapter>()),
  );
  di.registerSingleton(
    LocalLoadCurrentAccount(localDataSource: di<LocalDataSourceAdapter>()),
  );

  di.registerSingleton(
    LocalLoadAnnotations(localDataSource: di<LocalDataSourceAdapter>()),
  );
  di.registerSingleton(
    LocalSaveAnnotation(localDataSource: di<LocalDataSourceAdapter>()),
  );
  di.registerSingleton(
    LocalDeleteAnnotation(localDataSource: di<LocalDataSourceAdapter>()),
  );
  di.registerSingleton(
    LocalUpdateAnnotation(localDataSource: di<LocalDataSourceAdapter>()),
  );

  //stores

  di.registerSingleton(
    SplashPresenterStore(loadCurrentAccount: di<LocalLoadCurrentAccount>()),
  );

  di.registerSingleton(
    LoginPresenterStore(
        remoteAuthentication: di<RemoteAuthentication>(),
        saveCurrentAccount: di<LocalSaveCurrentAccount>()),
  );

  di.registerFactory(
    () => HomePresenterStore(
      localLoadAnnotations: di<LocalLoadAnnotations>(),
      localDataSourceAdapter: di<LocalDataSourceAdapter>(),
    ),
  );

  di.registerFactory(
    () => AnnotationPresenterStore(
      localSaveAnnotation: di<LocalSaveAnnotation>(),
      deleteAnnotation: di<LocalDeleteAnnotation>(),
      updateAnnotation: di<LocalUpdateAnnotation>(),
    ),
  );
}
