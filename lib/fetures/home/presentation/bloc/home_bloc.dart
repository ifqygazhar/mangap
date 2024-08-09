import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/fetures/home/domain/entities/komik_genre.dart';
import 'package:mangap/fetures/home/domain/entities/komik_popular_entity.dart';
import 'package:mangap/fetures/home/domain/entities/komik_recommended_entity.dart';
import 'package:mangap/fetures/home/domain/usecases/get_genre_komik.dart';
import 'package:mangap/fetures/home/domain/usecases/get_recommended_komik.dart';
import 'package:mangap/fetures/home/domain/usecases/get_popular_komik.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPopularKomik _getPopularKomik;
  final GetRecommended _getRecommendedKomik;
  final GetGenreKomik _getGenreKomik;

  HomeBloc({
    required GetPopularKomik getPopularKomik,
    required GetRecommended getRecommendedKomik,
    required GetGenreKomik getGenreKomik,
  })  : _getPopularKomik = getPopularKomik,
        _getRecommendedKomik = getRecommendedKomik,
        _getGenreKomik = getGenreKomik,
        super(const HomeState()) {
    on<HomeGetPopularKomik>(_getPopularKomikHandler);
    on<HomeGetRecommendedKomik>(_getRecommendedKomikHandler);
    on<HomeGetGenreKomik>(_getGenreHandler);
    on<HomeRefresh>(_refreshHandler);

    _initialize();
  }

  void _initialize() {
    add(HomeGetPopularKomik());
    add(HomeGetRecommendedKomik());
    add(HomeGetGenreKomik());
  }

  Future<void> _getPopularKomikHandler(
      HomeGetPopularKomik event, Emitter<HomeState> emit) async {
    final result = await _getPopularKomik();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (komiks) => emit(
        state.copyWith(
          status: HomeStatus.success,
          popularKomiks: komiks,
        ),
      ),
    );
  }

  Future<void> _getRecommendedKomikHandler(
      HomeGetRecommendedKomik event, Emitter<HomeState> emit) async {
    final result = await _getRecommendedKomik();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (komiks) => emit(
        state.copyWith(
          status: HomeStatus.success,
          recommendedKomiks: komiks,
        ),
      ),
    );
  }

  Future<void> _getGenreHandler(
      HomeGetGenreKomik event, Emitter<HomeState> emit) async {
    final result = await _getGenreKomik();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (komiks) => emit(
        state.copyWith(
          status: HomeStatus.success,
          genreKomiks: komiks,
        ),
      ),
    );
  }

  Future<void> _refreshHandler(
      HomeRefresh event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final popularResult = await _getPopularKomik();
    final recommendedResult = await _getRecommendedKomik();
    final genreResult = await _getGenreKomik();

    if (popularResult.isLeft() ||
        recommendedResult.isLeft() ||
        genreResult.isLeft()) {
      final errorMessage = popularResult.fold(
        (failure) => failure.errorMessage,
        (_) => recommendedResult.fold(
          (failure) => failure.errorMessage,
          (_) => genreResult.fold(
            (failure) => failure.errorMessage,
            (_) => null,
          ),
        ),
      );
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: errorMessage,
      ));
    } else {
      final popularKomiks = popularResult.getOrElse(() => []);
      final recommendedKomiks = recommendedResult.getOrElse(() => []);
      final genreKomiks = genreResult.getOrElse(() => []);
      emit(state.copyWith(
        status: HomeStatus.success,
        popularKomiks: popularKomiks,
        recommendedKomiks: recommendedKomiks,
        genreKomiks: genreKomiks,
      ));
    }
  }
}
