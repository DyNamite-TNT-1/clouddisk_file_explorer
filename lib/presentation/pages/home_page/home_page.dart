import 'package:clouddisk_login_form/api/auth.dart';
import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
import 'package:clouddisk_login_form/models/item.dart';
import 'package:clouddisk_login_form/presentation/screens/folder_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FolderTreeBloc folderTreeBloc = FolderTreeBloc();
  @override
  void initState() {
    folderTreeBloc.add(const LoadEvent(""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onSelected(BuildContext context, int value) {
      switch (value) {
        case 0:
          print("Download");
          break;
        default:
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
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
      // body: FolderScreen(
      //   folders: folders,
      // ),
      body: BlocProvider(
        create: (context) => folderTreeBloc,
        child: BlocBuilder<FolderTreeBloc, FolderTreeState>(
          builder: (context, state) {
            if (state is FolderTreeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FolderTreeLoaded) {
              return FolderScreen(
                folders: state.items,
              );
            }
            return Container();
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
