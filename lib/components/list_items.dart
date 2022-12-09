import 'package:clouddisk_login_form/components/item_file.dart';
import 'package:clouddisk_login_form/models/item.dart';
import 'package:flutter/material.dart';

class ListItems extends StatelessWidget {
  final List<Item> items;
  const ListItems({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ItemFile(
        item: items[index],
        onPressed: () {
          // if (items[index] is Folder) {
          //   BlocProvider.of<FolderRootBloc>(context).add(
          //     LoadEvent(items[index].id),
          //   );
          // }
          print("Click folder");
        },
      ),
    );
  }
}
