import 'dart:math';

import 'package:clouddisk_login_form/icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item {
  final String id;
  final String text;
  final String type;
  final String size;
  final String regdate;
  final String ext;
  Item(
    this.id,
    this.text,
    this.type,
    this.size,
    this.regdate,
    this.ext,
  );
}

class Folder extends Item {
  Color? color;
  IconData? icon;
  Folder(String id, String text, String type, String size, String regdate,
      String ext, this.color, this.icon)
      : super(id, text, type, size, regdate, ext);

  void addColorandIcon(Color color, IconData icon) {
    if (type == "file") {
      final List<String> texts = text.split(".");
      switch (texts.last) {
        case "doc":
          this.icon = AppIcon.fileWord;
          break;
        case "docx":
          this.icon = AppIcon.fileWord;
          break;
        case "ppt":
          this.icon = AppIcon.filePowerpoint;
          break;
        case "pptx":
          this.icon = AppIcon.filePowerpoint;
          break;
        case "xls":
          this.icon = AppIcon.fileExcel;
          break;
        case "xlsx":
          this.icon = AppIcon.fileExcel;
          break;
        case "zip":
          this.icon = AppIcon.fileArchive;
          break;
        case "pdf":
          this.icon = AppIcon.filePdf;
          break;
        case "mp3":
          this.icon = AppIcon.fileAudio;
          break;
        case "mp4":
          this.icon = AppIcon.fileVideo;
          break;
        case "jpg":
          this.icon = AppIcon.fileImage;
          break;
        case "png":
          this.icon = AppIcon.fileImage;
          break;
        default:
          this.icon = AppIcon.docText;
      }
    } else {
      this.color = color;
      this.icon = icon;
    }
  }

  String formatBytes(String size, int decimals) {
    //decimals: làm tròn tới decimals số thập phân
    int bytes = int.parse(size);
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  String formatDates(String regdate) {
    if (regdate == "0") return "";
    int milisecond = int.parse(regdate);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milisecond * 1000);
    String dateString = DateFormat("yyyy/MM/dd").format(date);
    return dateString;
  }

  String buildThumbnail(String ext) {
    if (ext[0] != "/") return "";
    return "https://groupware57.hanbiro.net${ext}_76x76.png";
  }

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      json["id"] as String,
      json["text"] as String,
      json["type"] as String,
      "${json["size"]}", //vì api trả về nếu >0 => String, = 0 thì là int
      "${json["regdate"]}", //vì api trả về nếu >0 => String, = 0 thì là int
      "${json["ext"]}",
      null,
      null,
    );
  }

  @override
  String toString() =>
      "Folder(id: $id, text: $text, type: $type, size: $size, regdate: $regdate, ext: $ext, icon: $icon, color: $color)";
}

List<Folder> folders = [];
List<Folder> preFolders = [];
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

// void sortListItem(List<Folder> folders, int sortType, int order) {
//   if (sortType == 0) {
//     if (order == 0) {
//       folders.sort((a, b) {
//         return int.parse(a.size).compareTo(int.parse(b.size));
//       });
//       // print(folders);
//     }
//     if (order == 1) {
//       folders.sort((a, b) {
//         return int.parse(b.size).compareTo(int.parse(a.size));
//       });
//       // print(folders);
//     }
//   }
// }
