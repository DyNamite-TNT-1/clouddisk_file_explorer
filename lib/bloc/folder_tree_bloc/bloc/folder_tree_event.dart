part of 'folder_tree_bloc.dart';

abstract class FolderTreeEvent extends Equatable {
  const FolderTreeEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends FolderTreeEvent {
  final String id;

  const LoadEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SortListEvent extends FolderTreeEvent {
  final String id;
  final String sort;
  final String order;
  const SortListEvent(this.id, this.sort, this.order);
  @override
  List<Object> get props => [id, sort, order];
}
