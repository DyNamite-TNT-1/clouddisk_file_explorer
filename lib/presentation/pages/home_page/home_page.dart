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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    //add drawer under appBar by using Scaffold below Scaffold
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: const Text("Home"),
        leading: IconButton(
          onPressed: () {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              Navigator.pop((context));
            } else {
              scaffoldKey.currentState!.openDrawer();
            }
          },
          icon: const Icon(Icons.menu),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(bottom: 0),
                child: Image.asset(
                  "assets/images/bg_profile.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              ListTile(
                title: const Text("Item => 1"),
                onTap: () {
                  print("tap1");
                },
              ),
              ListTile(
                title: const Text("Item => 2"),
                onTap: () {
                  print("tap2");
                },
              ),
            ],
          ),
        ),
        body: FolderScreen(
          folders: folders[0].children,
        ),
      ),
    );
  }
}
