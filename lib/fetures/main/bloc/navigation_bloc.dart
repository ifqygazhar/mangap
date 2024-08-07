import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(pageIndex: 0)) {
    on<NavigateToPage>((event, emit) {
      emit(NavigationState(pageIndex: event.pageIndex));
    });
  }
}
