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
        getGenreKomik: sl(),
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
    ..registerLazySingleton(
      () => GetGenreKomik(
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
    );

  //feature detail
  sl
    ..registerFactory(
      () => DetailBloc(
        getDetail: sl(),
        getGenre: sl(),
        getChapter: sl(),
      ),
    )

    //usecase
    ..registerLazySingleton(
      () => GetDetail(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetGenre(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetChapter(
        repository: sl(),
      ),
    )

    //repository
    ..registerLazySingleton<DetailRepository>(
      () => DetailRepositoryImpl(
        dataSource: sl(),
        networkInfo: sl(),
      ),
    )

    //data source
    ..registerLazySingleton<DetailRemoteDataSource>(
      () => DetailRemoteDataSourceImpl(
        client: sl(),
      ),
    );

  //feature genre detail
  sl
    ..registerFactory(
      () => GenreDetailBloc(
        getDetailGenreData: sl(),
        getGenrePage: sl(),
      ),
    )

    //use case
    ..registerLazySingleton(
      () => GetGenrePage(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetDetailGenreData(
        repository: sl(),
      ),
    )

    //repository
    ..registerLazySingleton<GenreRepository>(
      () => GenreRepositoryImpl(
        dataSource: sl(),
        networkInfo: sl(),
      ),
    )

    //data source
    ..registerLazySingleton<GenreRemoteDatasource>(
      () => GenreRemoteDataSourceImpl(
        client: sl(),
      ),
    );

  //feature manga list
  sl
    ..registerFactory(
      () => MangaBloc(
        getAllManga: sl(),
      ),
    )

    //usecase
    ..registerLazySingleton(
      () => GetAllManga(repository: sl()),
    )

    //repository
    ..registerLazySingleton<MangaRepository>(
      () => MangaRepositoryImpl(
        dataSource: sl(),
        networkInfo: sl(),
      ),
    )

    //data source
    ..registerLazySingleton<MangaRemoteDataSource>(
      () => MangaRemoteDataSourceImpl(
        client: sl(),
      ),
    );

  //feature search
  sl
    ..registerFactory(
      () => SearchBloc(
        getSearch: sl(),
      ),
    )

    //usecase
    ..registerLazySingleton(
      () => GetSearch(repository: sl()),
    )

    //repository
    ..registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(
        dataSource: sl(),
        networkInfo: sl(),
      ),
    )

    //data source
    ..registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDatasourceImpl(
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
