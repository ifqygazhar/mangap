part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeGetPopularKomik extends HomeEvent {}

class HomeGetUpdateKomik extends HomeEvent {
  const HomeGetUpdateKomik({required this.page});
  final String page;

  @override
  List<String> get props => [page];
}

class HomeRefresh extends HomeEvent {}
