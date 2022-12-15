import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
import 'package:clouddisk_login_form/components/list_items.dart';
import 'package:clouddisk_login_form/main.dart';
import 'package:clouddisk_login_form/models/user.dart';
import 'package:clouddisk_login_form/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({
    super.key,
    required this.folderId,
  });
  final String folderId;
  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  final FolderTreeBloc folderTreeBloc = FolderTreeBloc();
  @override
  void initState() {
    //nếu đang ở folder gốc thì clear toàn bộ chặng đường đã đi và add lại folder gốc vào listPaths
    if (widget.folderId == "") {
      listPaths.clear();
      listPaths.add("");
    }
    folderTreeBloc.add(LoadEvent(widget.folderId));
    super.initState();
  }

  @override
  void dispose() {
    folderTreeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => folderTreeBloc,
      child: BlocBuilder<FolderTreeBloc, FolderTreeState>(
        builder: (context, state) {
          if (state is FolderTreeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FolderTreeLoaded) {
            return Scaffold(
              body: Column(
                children: [
                  widget.folderId == ""
                      ? Container()
                      : Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.only(left: 4, top: 5, bottom: 5),
                          decoration:
                              BoxDecoration(color: Colors.cyan.shade300),
                          child: Text(
                            path.truePath(listPaths),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                  Expanded(
                    child: ListItems(items: state.items),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
