part of 'depedency_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initHome();
}

Future<void> _initHome() async {
  //feature main page
  sl.registerFactory(
    () => NavigationBloc(),
  );

  //feature home
  sl
    ..registerFactory(
      () => HomeBloc(
        getPopularKomik: sl(),
        getRecommendedKomik: sl(),
      ),
    )
    //usecase
    ..registerLazySingleton(
      () => GetPopularKomik(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetRecommended(
        repository: sl(),
      ),
    )

    //repository
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        dataSource: sl(),
        networkInfo: sl(),
      ),
    )
    //data source
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        client: sl(),
      ),
    )
    //other
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(networkInfo: sl()),
    )
    ..registerLazySingleton(InternetConnection.new)
    ..registerLazySingleton(http.Client.new);
}
