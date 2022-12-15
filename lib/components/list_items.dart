import 'package:clouddisk_login_form/components/item_file.dart';
import 'package:clouddisk_login_form/models/item.dart';
import 'package:clouddisk_login_form/path.dart';
import 'package:flutter/material.dart';

class ListItems extends StatefulWidget {
  final List<Folder> items;
  const ListItems({super.key, required this.items});

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
              onPressed: () {
                Navigator.of(context).pushNamed("/folderScreen",
                    arguments: widget.items[index].id.toString());
                listPaths.add(widget.items[index].text);
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
