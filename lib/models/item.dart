import 'package:flutter/material.dart';

class Item {
  int id;
  String title;
  Item(this.id, this.title);
}

class File extends Item {
  String extension;
  String image;
  File(int id, String title, this.image, this.extension) : super(id, title);
}

class Folder extends Item {
  IconData? icon;
  Color? color;
  List<Item> children;
  Folder(
    int id,
    String title,
    this.icon,
    this.color,
    this.children,
  ) : super(id, title);
  void addChildren(List<Item> items) {
    for (Item item in items) {
      children.add(item);
    }
  }

  void updateIconandColor(List<Item> items) {
    for (Item item in items) {
      if (item is Folder) {
        item.icon = icon;
        item.color = color;
      }
    }
  }
}

List<File> files = [
  File(0, 'a', 'assets/images/file-image.png', "jpg"),
  File(1, 'smile', 'assets/images/file-image.png', "gif"),
  File(2, 'z', 'assets/images/file-image.png', "txt"),
  File(3, 'Beauty', 'assets/images/image.jpg', "jpg"),
  File(4, 'MusicFile', 'assets/images/file-image.png', "mp3"),
];

List<Folder> folders = [
  Folder(0, 'Home', null, null, []),
  Folder(1, 'My', Icons.folder, Colors.blueAccent.shade400, []),
  Folder(2, 'CloudFolder', Icons.cloud_sync, Colors.green.shade900, []),
  Folder(3, 'Company', Icons.snippet_folder, Colors.orange.shade400, []),
  Folder(4, 'Shared', Icons.share, Colors.purple.shade800, []),
  Folder(5, 'Notification Folder', Icons.campaign_outlined, Colors.brown, []),
  Folder(6, 'Guest Folder', Icons.source, Colors.teal.shade700, []),
  Folder(7, 'Trash', Icons.delete_outline, Colors.red.shade900, []),
  Folder(8, 'QA', null, null, []),
  Folder(9, 'Tester', null, null, []),
  Folder(10, 'Secure', null, null, []),
];

void fakeData() {
  folders[0].addChildren([
    folders[1],
    folders[2],
    folders[3],
    folders[4],
    folders[5],
    folders[6],
    folders[7],
  ]);
  folders[1].addChildren([
    folders[8],
    files[0],
    folders[9],
  ]);
  folders[2].addChildren([
    files[1],
  ]);
  folders[3].addChildren([
    folders[10],
  ]);
  folders[1].updateIconandColor(folders[1].children);
  folders[3].updateIconandColor(folders[3].children);
}
