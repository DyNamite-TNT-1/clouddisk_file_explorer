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
  String extension = "";
  @override
  void initState() {
    if (mapChecked[widget.item.id] == true) {
      setState(() {
        isChecked = true;
      });
    }
    if (widget.item.type == "file") {
      final List<String> text = widget.item.text.split(".");
      extension = text.last;
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
                      size: 26,
                    ),
                  )
                : Container(
                    // width: 55,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        extension,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 2,
              child: Text(
                widget.item.text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff121212),
                ),
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
