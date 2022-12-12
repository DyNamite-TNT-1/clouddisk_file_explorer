import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
import 'package:clouddisk_login_form/components/list_items.dart';
import 'package:clouddisk_login_form/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({
    super.key,
    required this.folders,
  });
  final List<Item> folders;
  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<FolderTreeBloc>(context).add(const BackEvent());
        return false;
      },
      child: Column(
        children: [
          // Text("path"),
          Expanded(
            child: ListItems(items: widget.folders),
          ),
        ],
      ),
    );
  }
}
