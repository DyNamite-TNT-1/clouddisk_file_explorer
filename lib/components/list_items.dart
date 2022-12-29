import 'package:clouddisk_login_form/bloc/sort_bloc/sort_bloc.dart';
import 'package:clouddisk_login_form/components/item_file.dart';
import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:clouddisk_login_form/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListItems extends StatefulWidget {
  const ListItems({
    super.key,
    required this.items,
    required this.onPressed,
  });
  final List<Folder> items;
  final VoidCallback onPressed;
  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    return (widget.items.isNotEmpty)
        ? ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) => ItemFile(
              item: widget.items[index],
              onPressed: (value) {
                if (widget.items[index].type == "dir") {
                  Navigator.of(context).pushNamed("/folderScreen", arguments: {
                    "folderId": widget.items[index].id.toString(),
                    "currentPath": "/${widget.items[index].text}",
                    // "sortBloc": context.read<SortBloc>()
                  });
                } else {
                  widget.onPressed();
                }
              },
            ),
          )
        : const Center(
            child: Text(
              "No Data",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          );
  }
}
