part of 'home_bloc.dart';

enum HomeStatus { loading, success, error }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.loading,
    this.popularKomiks = const [],
    this.recommendedKomiks = const [],
    this.genreKomiks = const [],
    this.errorMessage = '',
  });

  final HomeStatus status;

  final List<KomikPopularEntity> popularKomiks;
  final List<KomikRecommendedEntity> recommendedKomiks;
  final List<KomikGenreEntity> genreKomiks;

  final String errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    List<KomikPopularEntity>? popularKomiks,
    List<KomikRecommendedEntity>? recommendedKomiks,
    List<KomikGenreEntity>? genreKomiks,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      popularKomiks: popularKomiks ?? this.popularKomiks,
      recommendedKomiks: recommendedKomiks ?? this.recommendedKomiks,
      genreKomiks: genreKomiks ?? this.genreKomiks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        popularKomiks,
        recommendedKomiks,
        genreKomiks,
        errorMessage,
      ];
}
