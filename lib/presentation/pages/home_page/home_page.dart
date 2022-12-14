import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
import 'package:clouddisk_login_form/presentation/screens/folder_screen.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    void onSelected(BuildContext context, int value) {
      switch (value) {
        case 0:
          break;
        default:
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false, //turn off leading
          title: const Text("Home"),
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                  iconTheme: const IconThemeData(color: Colors.white),
                  textTheme: const TextTheme().apply(bodyColor: Colors.white)),
              child: PopupMenuButton<int>(
                offset: const Offset(0, 50),
                color: Colors.indigo.shade900,
                onSelected: (value) {
                  onSelected(context, value);
                },
                itemBuilder: ((context) {
                  return [
                    popupMenuItem("New Folder"),
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
          return !(navKey.currentState?.canPop() ?? true);
        },
        child: Navigator(
          key: navKey,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case "/":
                return MaterialPageRoute(
                  settings: settings,
                  builder: (context) {
                    return const FolderScreen(folderId: "");
                  },
                );

              case "/folderScreen":
                var arguments = settings.arguments as String;
                return MaterialPageRoute(
                  settings: settings,
                  builder: (context) {
                    return FolderScreen(folderId: arguments);
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
      padding: const EdgeInsets.all(0),
      value: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            const SizedBox(
              width: 6,
            ),
            const Icon(
              Icons.file_download_outlined,
              size: 16,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
