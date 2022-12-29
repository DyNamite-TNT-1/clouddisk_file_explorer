part of 'sort_bloc.dart';

abstract class SortEvent extends Equatable {
  const SortEvent();

  @override
  List<Object> get props => [];
}

class ClickedSortEvent extends SortEvent {
  final String sortType;
  final String order;
  const ClickedSortEvent(this.sortType, this.order);
  @override
  List<Object> get props => [sortType, order];
}
