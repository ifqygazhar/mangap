part of 'depedency_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initHome();
}

Future<void> _initHome() async {
  //feature home
  sl
    ..registerFactory(
      () => HomeBloc(
        getPopularKomik: sl(),
        getLatestKomik: sl(),
      ),
    )
    //usecase
    ..registerLazySingleton(
      () => GetLatestKomik(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetPopularKomik(
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
