part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeGetPopularKomik extends HomeEvent {}

class HomeGetRecommendedKomik extends HomeEvent {}

class HomeRefresh extends HomeEvent {}
