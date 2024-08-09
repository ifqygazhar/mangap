part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final int pageIndex;
  final bool showBottomBar;

  const NavigationState({
    required this.pageIndex,
    required this.showBottomBar,
  });

  NavigationState copyWith({
    int? pageIndex,
    bool? showBottomBar,
  }) {
    return NavigationState(
      pageIndex: pageIndex ?? this.pageIndex,
      showBottomBar: showBottomBar ?? this.showBottomBar,
    );
  }

  @override
  List<Object> get props => [pageIndex, showBottomBar];
}
