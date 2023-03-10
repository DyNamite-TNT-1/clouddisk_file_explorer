// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sort_event.dart';
part 'sort_state.dart';

//This bloc to manage event Clicked Sort in dialog
class SortBloc extends Bloc<SortEvent, SortState> {
  SortBloc() : super(SortInitial()) {
    on<SortEvent>((event, emit) {
      if (event is ClickedSortEvent) {
        if (!isClosed) {
          emit(SortClicked(event.sortType, event.order));
        }
      }
    });
  }
}
