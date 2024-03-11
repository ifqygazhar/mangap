import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/fetures/home/domain/entities/komik_entity.dart';
import 'package:mangap/fetures/home/domain/usecases/get_latest_komik.dart';
import 'package:mangap/fetures/home/domain/usecases/get_popular_komik.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetPopularKomik getPopularKomik,
    required GetLatestKomik getLatestKomik,
  })  : _getPopularKomik = getPopularKomik,
        _getLatestKomik = getLatestKomik,
        super(const HomeState()) {
    on<HomeGetPopularKomik>(getPopularKomikHandler);
    on<HomeGetLatestKomik>(getLatestKomikHandler);
  }

  final GetPopularKomik _getPopularKomik;
  final GetLatestKomik _getLatestKomik;

  Future<void> getPopularKomikHandler(
      HomeEvent event, Emitter<HomeState> emit) async {
    final result = await _getPopularKomik();
    result.fold((failure) {
      emit(
        state.copyWith(
            status: HomeStatus.error, errorMessage: failure.errorMessage),
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

  Future<void> getLatestKomikHandler(
      HomeEvent event, Emitter<HomeState> emit) async {
    final result = await _getLatestKomik();
    result.fold((failure) {
      emit(
        state.copyWith(
            status: HomeStatus.error, errorMessage: failure.errorMessage),
      );
    }, (komiks) {
      emit(
        state.copyWith(
          status: HomeStatus.success,
          latestKomiks: komiks,
        ),
      );
    });
  }
}
