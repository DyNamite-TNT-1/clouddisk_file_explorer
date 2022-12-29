import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
import 'package:clouddisk_login_form/bloc/sort_bloc/sort_bloc.dart';
import 'package:clouddisk_login_form/components/list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({
    super.key,
    required this.folderId,
    required this.currentPath,
    required this.onPressed,
  });
  final String folderId;
  final String currentPath;
  final VoidCallback onPressed;
  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  final FolderTreeBloc folderTreeBloc = FolderTreeBloc();

  @override
  void initState() {
    // if (widget.isSort) {
    //   folderTreeBloc
    //       .add(SortListEvent(widget.folderId, widget.sortType, widget.order));
    // } else {
    folderTreeBloc.add(LoadEvent(widget.folderId));
    // }
    super.initState();
  }

  @override
  void dispose() {
    folderTreeBloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    // if (widget.isSort) {
    //   folderTreeBloc
    //       .add(SortListEvent(widget.folderId, widget.sortType, widget.order));
    // } else {
    folderTreeBloc.add(LoadEvent(widget.folderId));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => folderTreeBloc,
      child: BlocListener<SortBloc, SortState>(
        listener: (context, state) {
          if (state is SortClicked) {
            folderTreeBloc.add(
                SortListEvent(widget.folderId, state.sortType, state.order));
          }
        },
        child: BlocListener<FolderTreeBloc, FolderTreeState>(
          listener: (context, state) {
            // if (state is FolderTreeLoading) {
            //   print("loading");
            // } else if (state is FolderTreeLoaded) {
            //   print("loaded");
            // }
          },
          child: BlocBuilder<FolderTreeBloc, FolderTreeState>(
            builder: (context, state) {
              return Column(
                children: [
                  widget.folderId == ""
                      ? Container()
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              left: 12, top: 8, bottom: 8),
                          decoration:
                              BoxDecoration(color: Colors.cyan.shade100),
                          child: Text(
                            widget.currentPath,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                  if (state is FolderTreeLoading)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (state is FolderTreeLoaded)
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListItems(
                          items: state.items,
                          onPressed: () {
                            widget.onPressed();
                          },
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
