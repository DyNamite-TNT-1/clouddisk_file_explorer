// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';

import 'package:flutter/material.dart';

import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:clouddisk_login_form/presentation/screens/folder_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navKey = GlobalKey<NavigatorState>();
  var path = "";

  void onSelected(BuildContext context, int value) {
    switch (value) {
      case 0:
        showDialog(
          context: context,
          builder: (context) {
            return MyDialog(
              onValueChange: (int value1, int value2) {
                switch (value1) {
                  case 0:
                    sortType = "size";
                    break;
                  case 1:
                    sortType = "name";
                    break;
                  case 2:
                    sortType = "time";
                    break;
                }
                switch (value2) {
                  case 0:
                    order = "asc";
                    break;
                  case 1:
                    order = "desc";
                    break;
                }
              },
              onSave: () {
                print("Sort Type: $sortType");
                print("Order: $order");
              },
            );
          },
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false, //turn off leading
        title: Row(
          children: [
            const Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              " ${mapChecked.isNotEmpty ? "(" : ""}${mapChecked.isNotEmpty ? mapChecked.length : ""}${mapChecked.isNotEmpty ? ")" : ""}",
              style: const TextStyle(
                color: Colors.amberAccent,
              ),
            ),
          ],
        ),
        actions: [
          mapChecked.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Đang gửi..."),
                      ),
                    );
                  },
                )
              : Container(),
          Theme(
            data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.white),
                textTheme: const TextTheme().apply(bodyColor: Colors.white)),
            child: PopupMenuButton<int>(
              color: Colors.indigo,
              onSelected: (value) {
                onSelected(context, value);
              },
              itemBuilder: ((context) {
                return [
                  popupMenuItem("Sort"),
                ];
              }),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          setState(() {
            //xóa thằng cuối khi pop
            var chars = path.split("/");
            chars.removeLast();
            path = chars.join("/");
          });
          if (navKey.currentState != null) {
            if (navKey.currentState!.canPop()) {
              navKey.currentState!.pop();
              return false;
            }
          }
          return true;
        },
        child: Navigator(
          key: navKey,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case "/":
                return MaterialPageRoute(
                  settings: settings,
                  builder: (context) {
                    return FolderScreen(
                      folderId: "",
                      currentPath: "",
                      onPressed: () {
                        setState(() {});
                      },
                    );
                  },
                );
              case "/folderScreen":
                var arguments = settings.arguments as Map;
                var folderId = arguments["folderId"];
                var currentPath = arguments["currentPath"];
                path += currentPath;
                if (path[0] == "/") path = path.substring(1);
                return MaterialPageRoute(
                  settings: settings,
                  builder: (context) {
                    return FolderScreen(
                      folderId: folderId,
                      currentPath: path,
                      onPressed: () {
                        setState(() {});
                      },
                    );
                  },
                );
            }
            return null;
          },
        ),
      ),
    );
  }

  PopupMenuItem<int> popupMenuItem(String content) {
    return PopupMenuItem<int>(
      padding: const EdgeInsets.only(left: 16),
      value: 0,
      child: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class RadioList extends StatefulWidget {
  const RadioList({
    Key? key,
    required this.listItem,
    required this.onTap,
  }) : super(key: key);
  final List<String> listItem;
  final void Function(int) onTap;
  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  int selectedRadio = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.listItem.map((item) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedRadio = widget.listItem.indexOf(item);
              widget.onTap(selectedRadio);
            });
          },
          child: Row(
            children: [
              Radio(
                value: widget.listItem.indexOf(item),
                groupValue: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio = value!;
                    widget.onTap(selectedRadio);
                  });
                },
              ),
              SizedBox(
                width: 180,
                child: Text(item),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({
    Key? key,
    required this.onValueChange,
    required this.onSave,
  }) : super(key: key);
  final void Function(int, int) onValueChange;
  final VoidCallback onSave;
  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  int sortType = 0;
  int order = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 170,
        height: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sort Type",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  RadioList(
                    listItem: const ["Size", "File Name", "Date"],
                    onTap: (value) {
                      sortType = value;
                      widget.onValueChange(sortType, order);
                    },
                  ),
                  const Text(
                    "Order",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  RadioList(
                    listItem: const ["Ascending", "Descending"],
                    onTap: (value) {
                      order = value;
                      widget.onValueChange(sortType, order);
                    },
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                color: Colors.black54,
                size: 36,
              ),
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            padding: EdgeInsets.zero,
            fixedSize: const Size(135, 40),
          ),
          child: const Text(
            "SAVE AS DEFAULT",
            style: TextStyle(fontSize: 12),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onSave();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            padding: EdgeInsets.zero,
            fixedSize: const Size(135, 40),
          ),
          child: const Text(
            "SAVE",
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
