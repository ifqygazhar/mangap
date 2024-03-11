part of 'home_bloc.dart';

enum HomeStatus { loading, success, error }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.loading,
    this.popularKomiks = const [],
    this.latestKomiks = const [],
    this.errorMessage = '',
  });

  final HomeStatus status;

  final List<KomikEntity> popularKomiks;
  final List<KomikEntity> latestKomiks;

  final String errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    List<KomikEntity>? popularKomiks,
    List<KomikEntity>? latestKomiks,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      popularKomiks: popularKomiks ?? this.popularKomiks,
      latestKomiks: latestKomiks ?? this.latestKomiks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        popularKomiks,
        latestKomiks,
        errorMessage,
      ];
}
