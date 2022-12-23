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
  late bool sorted = false;
  @override
  void initState() {
    folderTreeBloc.add(LoadEvent(widget.folderId));
    currentId = widget.folderId;
    super.initState();
  }

  Future<void> _refresh() async {
    if (sorted) {
      folderTreeBloc.add(SortEvent(widget.folderId, sortType, order));
    } else {
      folderTreeBloc.add(LoadEvent(widget.folderId));
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("${widget.folderId}...$isSort...$isClickedDefault");
    //Khi nhấn nút "Save on Default" hoặc "Save" thì sẽ setState lại(ở homepage.dart), nên tất cả màn hình con đều bị ảnh hưởng,
    //=>> thêm điều kiện "currentId == widget.folderId" để chỉ áp dụng cho 1 màn hình đang hiển thị
    if (isSort && currentId == widget.folderId) {
      sorted = true;
      folderTreeBloc.add(SortEvent(widget.folderId, sortType, order));
    }
    if (isClickedDefault && currentId == widget.folderId) {
      sorted = false;
      folderTreeBloc.add(LoadEvent(widget.folderId));
    }
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
