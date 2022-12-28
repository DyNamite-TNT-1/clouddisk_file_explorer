import 'package:clouddisk_login_form/global_variable/global_variable.dart';
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
  bool hasThumbnail = false;
  late Widget image;
  Future<void> getImage(String ext) async {
    image = Image.network(
      widget.item.buildThumbnail(ext),
      height: 40,
    );
    setState(() {
      hasThumbnail = true;
    });
  }

  @override
  void initState() {
    //kiểm tra trong list, phần tử nào có "id" = itemId và "checked" = true thì setState
    if (listMapChecked.isNotEmpty) {
      if (listMapChecked
              .indexWhere((element) => element["id"] == widget.item.id) !=
          -1) {
        isChecked = true;
      }
    }
    if (widget.item.buildThumbnail(widget.item.ext) != "") {
      getImage(widget.item.ext).then((_) {});
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
              listMapChecked.add({
                "id": widget.item.id,
                "name": widget.item.text,
                "checked": true,
              });
            } else {
              listMapChecked
                  .removeWhere((element) => element["id"] == widget.item.id);
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
          ),
        ),
        child: Row(
          children: [
            //Stack để khi load thumbnail xong sẽ đè lên icon, không bị xấu UI. Không dùng stack thì sẽ gây hiện tượng thụt vào thụt ra của content
            Stack(
              children: [
                if (widget.item.type == "dir")
                  Container(
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
                else
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey.shade400,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Icon(
                      widget.item.icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                if (hasThumbnail) image,
              ],
            ),
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
                          listMapChecked.add({
                            "id": widget.item.id,
                            "name": widget.item.text,
                            "checked": true,
                          });
                        } else {
                          listMapChecked.removeWhere(
                              (element) => element["id"] == widget.item.id);
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
