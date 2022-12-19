import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:clouddisk_login_form/presentation/screens/folder_screen.dart';
import 'package:flutter/material.dart';

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
  int selectedIndex = 0;
  int selectedRadioTile = 0;
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future pushDialog() {
      return showDialog(
          useRootNavigator: false,
          context: context,
          builder: (context) {
            int selectedRadio = 0;
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                width: 170,
                height: 250,
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
                          // StatefulBuilder(builder:
                          //     (BuildContext context, StateSetter setState) {
                          //   List<String> list = ["Size", "File Name", "Date"];
                          //   return Column(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: List<Widget>.generate(3, (int index) {
                          //       return Row(
                          //         children: [
                          //           Radio<int>(
                          //             value: index,
                          //             groupValue: selectedRadio,
                          //             onChanged: (value) {
                          //               setState(() => selectedRadio = value!);
                          //             },
                          //           ),
                          //           const SizedBox(width: 8),
                          //           Text(list[index]),
                          //         ],
                          //       );
                          //     }),
                          //   );
                          // }),
                          const Text(
                            "Order",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
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
                  onPressed: () {},
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
          });
    }

    void onSelected(BuildContext context, int value) {
      switch (value) {
        case 0:
          pushDialog();
          break;
        default:
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
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
