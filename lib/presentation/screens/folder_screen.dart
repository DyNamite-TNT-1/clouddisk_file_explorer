import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
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
                          padding: const EdgeInsets.only(
                              left: 12, top: 8, bottom: 8),
                          decoration:
                              BoxDecoration(color: Colors.cyan.shade100),
                          child: Text(
                            widget.currentPath,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                  Expanded(
                    child: ListItems(
                      items: state.items,
                      onPressed: () {
                        widget.onPressed();
                      },
                    ),
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
