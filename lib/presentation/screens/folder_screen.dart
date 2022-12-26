import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
import 'package:clouddisk_login_form/components/list_items.dart';
import 'package:clouddisk_login_form/global_variable/global_variable.dart';
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
    if (isSort) {
      print("$sortType...$order");
      folderTreeBloc.add(SortEvent(widget.folderId, sortType, order));
    } else {
      folderTreeBloc.add(LoadEvent(widget.folderId));
    }
    currentId = widget.folderId;
    super.initState();
  }

  Future<void> _refresh() async {
    if (isSort) {
      folderTreeBloc.add(SortEvent(widget.folderId, sortType, order));
    } else {
      folderTreeBloc.add(LoadEvent(widget.folderId));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(isSort);
    print("$currentId...${widget.folderId}...$preId");
    //=>> thêm điều kiện "currentId == widget.folderId" để chỉ áp dụng cho 1 màn hình đang hiển thị
    // Bấm save, tức là tiêu chí sort được áp dụng. (k áp dụng tiêu chí sort đó cho sau này, nghĩa là khi kill app, mở lên lại thì app default)
    // Khi push màn hình mới thì sẽ auto sort màn hình mới đó theo tiêu chí sort
    // Khi pop, màn hình giữ nguyên như cũ, pull down to refresh mới sort theo tiêu chí sort
    if (isSort && currentId == widget.folderId) {
      print(1);
      folderTreeBloc.add(SortEvent(widget.folderId, sortType, order));
    }
    // else {
    //   currentId == widget.folderId;
    // }
    // Save as default, tức là áp dụng tiêu chí sort đó cho sau này, nghĩa là khi kill app, mở lên lại thì app sẽ theo tiêu chí sort đó
    return BlocProvider(
      create: (context) => folderTreeBloc,
      child: BlocListener<FolderTreeBloc, FolderTreeState>(
        listener: (context, state) {
          if (state is FolderTreeLoading) {
            print("loading");
          } else if (state is FolderTreeLoaded) {
            print("loaded");
          }
        },
        child: BlocBuilder<FolderTreeBloc, FolderTreeState>(
          builder: (context, state) {
            return Scaffold(
              body: Column(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
