part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeGetHotKomik extends HomeEvent {}

class HomeGetPopularKomik extends HomeEvent {}

class HomeGetLatestKomik extends HomeEvent {}
