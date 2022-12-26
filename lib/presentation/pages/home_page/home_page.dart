import 'package:clouddisk_login_form/api/params/send_file_par.dart';
import 'package:clouddisk_login_form/bloc/send_file_bloc/send_file_bloc.dart';
import 'package:clouddisk_login_form/components/list_radio.dart';
import 'package:clouddisk_login_form/presentation/pages/home_page/conponents/send_dialog.dart';
import 'package:clouddisk_login_form/presentation/pages/home_page/conponents/sort_dialog.dart';
import 'package:flutter/material.dart';
import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:clouddisk_login_form/presentation/screens/folder_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  SendFile sendFile = SendFile([], "set");
  List<Map<String, dynamic>> listFileSend = [];

  Future onSend(BuildContext context) {
    return showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return SendDialog(
            onSend: (p0, p1) {
              for (var element in listMapChecked) {
                listFileSend.add({
                  "id": element["id"],
                  "name": element["name"],
                  "count": p0,
                  "expire": p1,
                });
              }
              sendFile.files = listFileSend;
              addEvent(); //gọi function ở dưới để sử dụng context của HomePage, vì context của HomePage nằm trong BlocProvider ở main.dart
            },
          );
        });
  }

  void addEvent() {
    BlocProvider.of<SendFileBloc>(context).add(CLickedSendEvent(sendFile));
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
    return BlocBuilder<SendFileBloc, SendFileState>(
      builder: (context, state) {
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
                  " ${listMapChecked.isNotEmpty ? "(" : ""}${listMapChecked.isNotEmpty ? listMapChecked.length : ""}${listMapChecked.isNotEmpty ? ")" : ""}",
                  style: const TextStyle(
                    color: Colors.amberAccent,
                  ),
                ),
              ],
            ),
            actions: [
              listMapChecked.isNotEmpty
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
      },
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
