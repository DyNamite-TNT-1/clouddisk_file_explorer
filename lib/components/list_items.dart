import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
import 'package:clouddisk_login_form/components/item_file.dart';
import 'package:clouddisk_login_form/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListItems extends StatefulWidget {
  final List<Item> items;
  const ListItems({super.key, required this.items});

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      header: CustomHeader(
        builder: ((context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("pull down to refresh");
          } else if (mode == LoadStatus.loading) {
            body = const Text("loading");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("release to refresh");
          } else {
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 35,
            child: Center(
              child: body,
            ),
          );
        }),
      ),
      onRefresh: onRefresh,
      child: (widget.items.isNotEmpty)
          ? ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) => ItemFile(
                item: widget.items[index],
                onPressed: () {
                  if (widget.items[index] is Folder) {
                    BlocProvider.of<FolderTreeBloc>(context).add(
                      LoadEvent(widget.items[index].id),
                    );
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
            ),
    );
  }
}
