part of 'home_bloc.dart';

enum HomeStatus { loading, success, error }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.loading,
    this.popularKomiks = const [],
    this.updateKomiks = const [],
    this.hasReachedMax = false,
    this.errorMessage = '',
  });

  final HomeStatus status;

  final List<KomikEntity> popularKomiks;
  final List<KomikEntity> updateKomiks;
  final bool hasReachedMax;

  final String errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    List<KomikEntity>? popularKomiks,
    List<KomikEntity>? updateKomiks,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      popularKomiks: popularKomiks ?? this.popularKomiks,
      updateKomiks: updateKomiks ?? this.updateKomiks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        popularKomiks,
        updateKomiks,
        hasReachedMax,
        errorMessage,
      ];
}
