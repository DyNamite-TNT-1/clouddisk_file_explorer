part of 'sort_bloc.dart';

abstract class SortState extends Equatable {
  const SortState();

  @override
  List<Object> get props => [];
}

class SortInitial extends SortState {}

class SortClicked extends SortState {
  final String sortType;
  final String order;
  const SortClicked(this.sortType, this.order);

  @override
  List<Object> get props => [sortType, order];
}
