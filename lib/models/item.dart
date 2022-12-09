import 'package:flutter/material.dart';

class Item {
  int id;
  String title;
  Item(this.id, this.title);
}

class File extends Item {
  String extension;
  File(int id, String title, this.extension) : super(id, title);
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
}

List<Folder> folders = [
  Folder(0, 'Home', null, null, []),
  Folder(1, 'My', Icons.folder, Colors.blueAccent.shade400, []),
  Folder(2, 'CloudFolder', Icons.cloud_sync, Colors.green.shade900, []),
  Folder(3, 'Company', Icons.snippet_folder, Colors.orange.shade400, []),
  Folder(4, 'Shared', Icons.share, Colors.purple.shade800, []),
  Folder(5, 'Notification Folder', Icons.campaign_outlined, Colors.brown, []),
  Folder(6, 'Guest Folder', Icons.source, Colors.teal.shade700, []),
  Folder(7, 'Trash', Icons.delete_outline, Colors.red.shade900, []),
];

void originalFolders() {
  folders[0].addChildren([
    folders[1],
    folders[2],
    folders[3],
    folders[4],
    folders[5],
    folders[6],
    folders[7],
  ]);
}
