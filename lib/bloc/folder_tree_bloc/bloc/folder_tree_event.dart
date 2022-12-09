part of 'folder_tree_bloc.dart';

abstract class FolderTreeEvent extends Equatable {
  const FolderTreeEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends FolderTreeEvent {
  final int id;
  const LoadEvent(this.id);

  @override
  List<Object> get props => [id];
}

class BackEvent extends FolderTreeEvent {
  const BackEvent();

  @override
  List<Object> get props => [];
}
