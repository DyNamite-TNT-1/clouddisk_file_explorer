import 'package:clouddisk_login_form/components/list_radio.dart';
import 'package:flutter/material.dart';
import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:clouddisk_login_form/presentation/screens/folder_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navKey = GlobalKey<NavigatorState>();
  bool canPop = false;
  var path = "";
  int initialValue1 = 0;
  int initialValue2 = 0;
  Future onSend(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const SendDialog();
        });
  }

  void onSelected(BuildContext context, int value) {
    switch (value) {
      case 0:
        showDialog(
          context: context,
          builder: (context) {
            return SortDialog(
              onValueChange: (int value1, int value2) {
                initialValue1 = value1;
                initialValue2 = value2;
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
                setState(() {
                  //nhấn Save sẽ gán isSort = true để tiến hành sort, isDefault = false
                  isSort = true;
                  isClickedDefault = false;
                });
              },
              onDefault: () {
                initialValue1 = 0;
                initialValue2 = 0;
                setState(() {
                  //nhấn Save as Default sẽ gán isDefault = true để trở lại list ban đầu chưa sort, isSort = false
                  //isClickedDefault có nghĩa là ấn nút Default hay không chứ không có nghĩa list đó default hay không
                  isClickedDefault = true;
                  isSort = false;
                });
              },
              initValue1: initialValue1,
              initValue2: initialValue2,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 28.0,
              width: 28.0,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  setState(() {
                    //xóa thằng cuối khi pop
                    var chars = path.split("/");
                    chars.removeLast();
                    path = chars.join("/");
                  });
                  if (navKey.currentState != null) {
                    if (navKey.currentState!.canPop()) {
                      navKey.currentState!.pop();
                    }
                  }
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              "CloudDisk",
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
                    onSend(context);
                  },
                )
              : Container(),
          PopupMenuButton<int>(
            color: Colors.white,
            constraints: const BoxConstraints(
              minWidth: 150,
            ),
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (value) {
              onSelected(context, value);
            },
            itemBuilder: ((context) {
              return [
                popupMenuItem("Sort"),
              ];
            }),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          currentId = preId;
          isSort = false;
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
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}

class SortDialog extends StatefulWidget {
  const SortDialog({
    Key? key,
    required this.onValueChange,
    required this.onSave,
    required this.onDefault,
    required this.initValue1,
    required this.initValue2,
  }) : super(key: key);
  final void Function(int, int) onValueChange;
  final VoidCallback onSave;
  final VoidCallback onDefault;
  final int initValue1;
  final int initValue2;

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
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
                    initValue: widget.initValue1,
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
                    initValue: widget.initValue2,
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
          onPressed: () {
            Navigator.of(context).pop();
            widget.onDefault();
          },
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

class SendDialog extends StatefulWidget {
  const SendDialog({super.key});

  @override
  State<SendDialog> createState() => _SendDialogState();
}

class _SendDialogState extends State<SendDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // contentPadding: EdgeInsets.zero,
      content: SizedBox(
        // width: 260,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Cloud Disk",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Expired Date (NOT less than current date)",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Download count (greate than 0)",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 18,
              ),
              initialValue: "100",
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(bottom: -20),
                hintText: "100",
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "CANCEL",
            style: TextStyle(fontSize: 14),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "OK",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
