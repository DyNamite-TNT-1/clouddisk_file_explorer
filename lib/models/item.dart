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
  Item({
    required this.id,
    required this.text,
    required this.type,
    required this.size,
    required this.regdate,
    required this.ext,
  });
}

class Folder extends Item {
  Color? color;
  IconData? icon;
  Folder(String id, String text, String type, String size, String regdate,
      String ext, this.color, this.icon)
      : super(
            id: id,
            text: text,
            type: type,
            size: size,
            regdate: regdate,
            ext: ext);

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
    var isNum = RegExp(r'^[0-9]*$').hasMatch(regdate);
    if (isNum) {
      //decimals: làm tròn tới decimals số thập phân
      int bytes = int.parse(size);
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1024)).floor();
      return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
    }
    //Nếu không thì in ra lỗi
    return "size is not only contains number";
  }

  String formatDates(String regdate) {
    if (regdate == "0") return "";
    //dùng regex, kiểm tra điều kiện regdate chỉ chứa ký tự số
    var isNum = RegExp(r'^[0-9]*$').hasMatch(regdate);
    //Nếu chỉ chứa ký tự số thì return ra date sau chuyển
    if (isNum) {
      int milisecond = int.parse(regdate);
      DateTime date = DateTime.fromMillisecondsSinceEpoch(milisecond * 1000);
      String dateString = DateFormat("yyyy/MM/dd").format(date);
      return dateString;
    }
    //Nếu không thì in ra lỗi
    return "regdate is not only contains number";
  }

  String buildThumbnail(String ext) {
    if (ext[0] != "/") return "";
    return "https://groupware57.hanbiro.net${ext}_76x76.png";
  }

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      "${json["id"]}",
      "${json["text"]}",
      "${json["type"]}",
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

class ListFolders {
  List<Folder> listFolders;
  ListFolders({required this.listFolders});
}
