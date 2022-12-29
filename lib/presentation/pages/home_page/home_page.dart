import 'package:clouddisk_login_form/api/params/send_file_par.dart';
import 'package:clouddisk_login_form/bloc/send_file_bloc/send_file_bloc.dart';
import 'package:clouddisk_login_form/bloc/sort_bloc/sort_bloc.dart';
import 'package:clouddisk_login_form/presentation/pages/home_page/conponents/send_dialog.dart';
import 'package:clouddisk_login_form/presentation/pages/home_page/conponents/sort_dialog.dart';
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
  bool canPop = false;
  var path = "";
  int initialValue1 = 0;
  int initialValue2 = 0;
  String sortType = "size";
  String order = "asc";
  SendFile sendFile = SendFile([], "set");
  late SortBloc sortBloc;
  @override
  initState() {
    sortBloc = context.read<SortBloc>();
    super.initState();
  }

  Future<void> onSend(BuildContext context) {
    return showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          List<Map<String, dynamic>> listFileSend = [];
          return BlocProvider.value(
            value: context.read<SendFileBloc>(),
            child: SendDialog(
              onSend: (p0, p1) {
                Navigator.of(context).pop();
                for (var element in listMapChecked) {
                  listFileSend.add({
                    "id": element["id"],
                    "name": element["name"],
                    "count": p0,
                    "expire": p1,
                  });
                }
                sendFile.files = listFileSend;
                context.read<SendFileBloc>().add(CLickedSendEvent(sendFile));
              },
            ),
          );
        });
  }

  void onSelected(BuildContext context, int value) async {
    switch (value) {
      case 0:
        await showDialog(
          context: context,
          builder: (context) {
            return BlocProvider.value(
              value: context.read<SortBloc>(),
              child: SortDialog(
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
                  Navigator.of(context).pop();
                  context
                      .read<SortBloc>()
                      .add(ClickedSortEvent(sortType, order));
                },
                onDefault: () {
                  Navigator.of(context).pop();
                },
                initValue1: initialValue1,
                initValue2: initialValue2,
              ),
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
            automaticallyImplyLeading: false,
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
                    // SortBloc sortBloc = arguments["sortBloc"];
                    path += currentPath;
                    if (path[0] == "/") path = path.substring(1);
                    return MaterialPageRoute(
                      settings: settings,
                      builder: (context) {
                        return BlocProvider.value(
                          value: sortBloc,
                          child: FolderScreen(
                            folderId: folderId,
                            currentPath: path,
                            onPressed: () {
                              setState(() {});
                            },
                          ),
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
