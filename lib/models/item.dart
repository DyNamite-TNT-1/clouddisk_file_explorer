import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item {
  final String id;
  final String text;
  Item(this.id, this.text);
}

class File extends Item {
  String extension;
  File(String id, String title, this.extension) : super(id, title);
}

class Folder extends Item {
  Color? color;
  IconData? icon;
  List<Item> children;
  Folder(String id, String text, this.color, this.icon, this.children)
      : super(id, text);

  void addColorandIcon(Color color, IconData icon) {
    this.color = color;
    this.icon = icon;
  }

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      json['id'] as String,
      json['text'] as String,
      null,
      null,
      [],
    );
  }

  @override
  String toString() => 'Folder(id: $id, text: $text)';
}

List<Folder> folders = [];
List<Folder> foldersRoot = [];

void addColorandIcon() {
  foldersRoot[0].addColorandIcon(Colors.blueAccent.shade400, Icons.folder);
  foldersRoot[1].addColorandIcon(Colors.green.shade900, Icons.cloud_sync);
  foldersRoot[2].addColorandIcon(Colors.orange.shade400, Icons.snippet_folder);
  foldersRoot[3].addColorandIcon(Colors.purple.shade800, Icons.share);
  foldersRoot[4].addColorandIcon(Colors.pink.shade300, Icons.star);
  foldersRoot[5].addColorandIcon(Colors.brown, Icons.campaign_outlined);
  foldersRoot[6].addColorandIcon(Colors.teal.shade700, Icons.source);
  foldersRoot[7].addColorandIcon(Colors.red.shade900, Icons.delete_outline);
}
