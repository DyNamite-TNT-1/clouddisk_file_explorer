import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
import 'package:clouddisk_login_form/components/item_leading.dart';
import 'package:clouddisk_login_form/presentation/pages/login_page/login_screen.dart';
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
    folderTreeBloc.add(const LoadEvent(0));
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

    //add drawer under appBar by using Scaffold below Scaffold
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
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
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                  iconTheme: const IconThemeData(color: Colors.white),
                  textTheme: const TextTheme().apply(bodyColor: Colors.white)),
              child: PopupMenuButton<int>(
                offset: const Offset(0, 60),
                shape: const TooltipShape(),
                color: Colors.indigo.shade900,
                onSelected: (value) {
                  onSelected(context, value);
                },
                itemBuilder: ((context) {
                  return [
                    popupMenuItem("Download"),
                    popupMenuItem("New Folder"),
                    popupMenuItem("Delete"),
                    popupMenuItem("Copy"),
                    popupMenuItem("Move"),
                    popupMenuItem("Favorite"),
                    popupMenuItem("Sort"),
                    // const PopupMenuItem<int>(
                    //   value: 1,
                    //   child: Text("New Folder"),
                    // ),
                    // const PopupMenuItem<int>(
                    //   value: 2,
                    //   child: Text("Delete"),
                    // ),
                    // const PopupMenuItem<int>(
                    //   value: 3,
                    //   child: Text("Copy"),
                    // ),
                    // const PopupMenuItem<int>(
                    //   value: 4,
                    //   child: Text("Move"),
                    // ),
                    // const PopupMenuItem<int>(
                    //   value: 5,
                    //   child: Text("Favorite"),
                    // ),
                    // const PopupMenuItem<int>(
                    //   value: 6,
                    //   child: Text("Sort"),
                    // ),
                  ];
                }),
              ),
            ),
          ],
        ),
      ),
      body: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(bottom: 24),
                child: Image.asset(
                  "assets/images/bg_profile.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              ItemLeading(
                icon: Icons.home,
                content: "Home",
                onPressed: () {},
              ),
              Divider(
                thickness: 1,
                height: 0,
                color: Colors.grey.shade300,
              ),
              ItemLeading(
                icon: Icons.star_outline,
                content: "Favourite",
                onPressed: () {},
              ),
              Divider(
                thickness: 1,
                height: 0,
                color: Colors.grey.shade300,
              ),
              ItemLeading(
                icon: Icons.cached,
                content: "Updates",
                onPressed: () {},
              ),
              Divider(
                thickness: 1,
                height: 0,
                color: Colors.grey.shade300,
              ),
              ItemLeading(
                icon: Icons.find_in_page,
                content: "File Explorer",
                onPressed: () {},
              ),
              Divider(
                thickness: 1,
                height: 0,
                color: Colors.grey.shade300,
              ),
              ItemLeading(
                icon: Icons.settings,
                content: "Settings",
                onPressed: () {},
              ),
              Divider(
                thickness: 1,
                height: 0,
                color: Colors.grey.shade300,
              ),
              ItemLeading(
                icon: Icons.logout,
                content: "Logout",
                onPressed: () {},
              ),
            ],
          ),
        ),
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
      ),
    );
  }

  PopupMenuItem<int> popupMenuItem(String content) {
    return PopupMenuItem<int>(
      padding: const EdgeInsets.all(0),
      value: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(
          color: Colors.red,
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
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

//Vẽ submenu
class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
