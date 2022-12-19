import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:clouddisk_login_form/icons/app_icons.dart';
import 'package:clouddisk_login_form/models/item.dart';
import 'package:flutter/material.dart';

class ItemFile extends StatefulWidget {
  final Folder item;
  final Function(bool) onPressed;
  const ItemFile({
    super.key,
    required this.item,
    required this.onPressed,
  });

  @override
  State<ItemFile> createState() => _ItemFileState();
}

class _ItemFileState extends State<ItemFile> {
  bool isChecked = false;
  late IconData iconData;
  @override
  void initState() {
    if (mapChecked[widget.item.id] == true) {
      setState(() {
        isChecked = true;
      });
    }
    if (widget.item.type == "file") {
      final List<String> text = widget.item.text.split(".");
      switch (text.last) {
        case "doc":
          iconData = AppIcon.fileWord;
          break;
        case "docx":
          iconData = AppIcon.fileWord;
          break;
        case "ppt":
          iconData = AppIcon.filePowerpoint;
          break;
        case "pptx":
          iconData = AppIcon.filePowerpoint;
          break;
        case "xls":
          iconData = AppIcon.fileExcel;
          break;
        case "xlsx":
          iconData = AppIcon.fileExcel;
          break;
        case "zip":
          iconData = AppIcon.fileArchive;
          break;
        case "pdf":
          iconData = AppIcon.filePdf;
          break;
        case "mp3":
          iconData = AppIcon.fileAudio;
          break;
        case "mp4":
          iconData = AppIcon.fileVideo;
          break;
        case "jpg":
          iconData = AppIcon.fileImage;
          break;
        case "png":
          iconData = AppIcon.fileImage;
          break;
        default:
          iconData = AppIcon.docText;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.item.type == "file") {
          setState(() {
            isChecked = !isChecked;
            if (isChecked) {
              mapChecked.addAll({widget.item.id: true});
            } else {
              mapChecked.remove(widget.item.id);
            }
          });
        }
        widget.onPressed(isChecked);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        )),
        child: Row(
          children: [
            widget.item.type == "dir"
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.item.color,
                    ),
                    child: Icon(
                      widget.item.icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  )
                : Container(
                    // width: 55,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey.shade400,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Icon(
                      iconData,
                      color: Colors.white,
                      size: 24,
                    )),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.text,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff121212),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        widget.item.formatBytes(widget.item.size, 1),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.item.formatDates(widget.item.regdate),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            (widget.item.type == "file")
                ? Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                        if (isChecked) {
                          mapChecked.addAll({widget.item.id: true});
                        } else {
                          mapChecked.remove(widget.item.id);
                        }
                      });
                      widget.onPressed(isChecked);
                    })
                : Container(),
          ],
        ),
      ),
    );
  }
}
