part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final int pageIndex;

  const NavigationState({required this.pageIndex});

  NavigationState copyWith({
    int? pageIndex,
  }) {
    return NavigationState(
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  List<Object> get props => [pageIndex];
}
