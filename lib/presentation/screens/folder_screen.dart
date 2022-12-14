import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
import 'package:clouddisk_login_form/components/list_items.dart';
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
    return BlocBuilder<FolderTreeBloc, FolderTreeState>(
      builder: (context, state) {
        if (state is FolderTreeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FolderTreeLoaded) {
          return Column(
            children: [
              // Text("path"),
              Expanded(
                child: ListItems(items: state.items),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
