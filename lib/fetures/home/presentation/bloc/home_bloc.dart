import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/fetures/home/domain/entities/komik_popular_entity.dart';
import 'package:mangap/fetures/home/domain/entities/komik_recommended_entity.dart';
import 'package:mangap/fetures/home/domain/usecases/get_recommended_komik.dart';
import 'package:mangap/fetures/home/domain/usecases/get_popular_komik.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetPopularKomik getPopularKomik,
    required GetRecommended getRecommendedKomik,
  })  : _getPopularKomik = getPopularKomik,
        _getRecommendedKomik = getRecommendedKomik,
        super(const HomeState()) {
    on<HomeGetPopularKomik>(getPopularKomikHandler);
    on<HomeGetRecommendedKomik>(getUpdateKomikHandler);
    on<HomeRefresh>(refreshHandler);

    add(HomeGetPopularKomik());
    add(HomeGetRecommendedKomik());
  }

  final GetPopularKomik _getPopularKomik;
  final GetRecommended _getRecommendedKomik;

  Future<void> getPopularKomikHandler(
      HomeEvent event, Emitter<HomeState> emit) async {
    final result = await _getPopularKomik();
    result.fold((failure) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: failure.errorMessage,
        ),
      );
    }, (komiks) {
      emit(
        state.copyWith(
          status: HomeStatus.success,
          popularKomiks: komiks,
        ),
      );
    });
  }

  Future<void> getUpdateKomikHandler(
      HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeGetRecommendedKomik) {
      final result = await _getRecommendedKomik();

      result.fold((failure) {
        emit(
          state.copyWith(
            status: HomeStatus.error,
            errorMessage: failure.errorMessage,
          ),
        );
      }, (komiks) {
        emit(
          state.copyWith(
            status: HomeStatus.success,
            recommendedKomiks: komiks,
          ),
        );
      });
    }
  }

  Future<void> refreshHandler(
      HomeRefresh event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final popularResult = await _getPopularKomik();
    final recommendedResult = await _getRecommendedKomik();

    popularResult.fold((failure) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: failure.errorMessage,
      ));
    }, (popularKomiks) {
      recommendedResult.fold((failure) {
        emit(state.copyWith(
          status: HomeStatus.error,
          errorMessage: failure.errorMessage,
        ));
      }, (recommendedKomiks) {
        emit(state.copyWith(
          status: HomeStatus.success,
          popularKomiks: popularKomiks,
          recommendedKomiks: recommendedKomiks,
        ));
      });
    });
  }
}
