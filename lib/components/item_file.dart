import 'package:clouddisk_login_form/models/item.dart';
import 'package:flutter/material.dart';

class ItemFile extends StatefulWidget {
  final Item item;
  final VoidCallback onPressed;

  const ItemFile({
    super.key,
    required this.item,
    required this.onPressed,
  });

  @override
  State<ItemFile> createState() => _ItemFileState();
}

class _ItemFileState extends State<ItemFile> {
  bool? check1 = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
          ),
        )),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.item is Folder
                    ? ((widget.item as Folder).color)
                    : null,
              ),
              child: widget.item is Folder
                  ? Icon(
                      (widget.item as Folder).icon,
                      color: Colors.white,
                      size: 26,
                    )
                  : null,
            ),
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
            (widget.item.text.contains("."))
                ? Checkbox(
                    value: check1,
                    onChanged: (bool? value) {
                      setState(() {
                        check1 = value;
                      });
                    })
                : Container(),
          ],
        ),
      ),
    );
  }
}
