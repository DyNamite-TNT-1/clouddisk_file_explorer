import 'package:clouddisk_login_form/models/item.dart';
import 'package:clouddisk_login_form/presentation/screens/folder_screen.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text("Home"),
          // actions: [],
        ),
      ),
      // drawer: D,
      body: FolderScreen(
        folders: folders[0].children,
      ),
      // ),
    );
  }
}
