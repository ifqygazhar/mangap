import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/fetures/home/domain/entities/komik_entity.dart';
import 'package:mangap/fetures/home/domain/usecases/get_list_by_update_komik.dart';
import 'package:mangap/fetures/home/domain/usecases/get_popular_komik.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetPopularKomik getPopularKomik,
    required GetListByUpdate getUpdateKomik,
  })  : _getPopularKomik = getPopularKomik,
        _getUpdateKomik = getUpdateKomik,
        super(const HomeState()) {
    on<HomeGetPopularKomik>(getPopularKomikHandler);
    on<HomeGetUpdateKomik>(getUpdateKomikHandler);
    on<HomeRefresh>(refreshHandler);
  }

  final GetPopularKomik _getPopularKomik;
  final GetListByUpdate _getUpdateKomik;

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

  Future<void> getUpdateKomikHandler(
      HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeGetUpdateKomik) {
      final result = await _getUpdateKomik(event.page);

      result.fold((failure) {
        emit(
          state.copyWith(
              status: HomeStatus.error, errorMessage: failure.errorMessage),
        );
      }, (komiks) {
        final newStories = List.of(state.updateKomiks)..addAll(komiks);
        final hasReachedMax = komiks.isEmpty;
        emit(
          state.copyWith(
            status: HomeStatus.success,
            updateKomiks: hasReachedMax ? state.updateKomiks : newStories,
            hasReachedMax: hasReachedMax,
          ),
        );
      });
    }
  }

  Future<void> refreshHandler(
      HomeRefresh event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
        status: HomeStatus.loading)); // Set status to loading before refreshing

    final popularResult = await _getPopularKomik();
    final updateResult = await _getUpdateKomik("1");

    popularResult.fold((failure) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: failure.errorMessage,
      ));
    }, (popularKomiks) {
      updateResult.fold((failure) {
        emit(state.copyWith(
          status: HomeStatus.error,
          errorMessage: failure.errorMessage,
        ));
      }, (updateKomiks) {
        emit(state.copyWith(
          status: HomeStatus.success,
          popularKomiks: popularKomiks,
          updateKomiks: updateKomiks,
          hasReachedMax: updateKomiks.isEmpty,
        ));
      });
    });
  }
}
