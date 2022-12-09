part of 'folder_tree_bloc.dart';

abstract class FolderTreeState extends Equatable {
  const FolderTreeState();

  @override
  List<Object> get props => [];
}

class FolderTreeInitial extends FolderTreeState {}

class FolderTreeLoading extends FolderTreeState {}

class FolderRootLoaded extends FolderTreeState {
  final List<Item> items;

  const FolderRootLoaded(this.items);

  @override
  List<Object> get props => [items];
}
