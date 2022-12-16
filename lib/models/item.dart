import 'package:flutter/material.dart';

class Item {
  final String id;
  final String text;
  final String type;
  final String regdate;
  final String size;
  Item(this.id, this.text, this.type, this.regdate, this.size);
}

class Folder extends Item {
  Color? color;
  IconData? icon;
  Folder(String id, String text, String type, String regdate, String size,
      this.color, this.icon)
      : super(id, text, type, regdate, size);

  void addColorandIcon(Color color, IconData icon) {
    this.color = color;
    this.icon = icon;
  }

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      json['id'] as String,
      json['text'] as String,
      json['type'] as String,
      json['regdate'] as String,
      json['size'] as String,
      null,
      null,
    );
  }

  @override
  String toString() => 'Folder(id: $id, text: $text, type: $type)';
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
