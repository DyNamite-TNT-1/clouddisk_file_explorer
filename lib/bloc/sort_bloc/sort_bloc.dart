// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:equatable/equatable.dart';

part 'sort_event.dart';
part 'sort_state.dart';

//This bloc to manage event Clicked Sort in dialog
class SortBloc extends Bloc<SortEvent, SortState> {
  SortBloc() : super(SortInitial()) {
    on<SortEvent>((event, emit) {
      if (event is ClickedSortEvent) {
        if (!isClosed) {
          isSort = true;
          emit(SortClicked(event.sortType, event.order));
        }
      }
    });
  }
}
