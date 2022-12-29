import 'package:clouddisk_login_form/components/list_radio.dart';
import 'package:flutter/material.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({
    Key? key,
    required this.onValueChange,
    required this.onSave,
    required this.onDefault,
    required this.initValue1,
    required this.initValue2,
  }) : super(key: key);
  final void Function(int, int) onValueChange;
  final VoidCallback onSave;
  final VoidCallback onDefault;
  final int initValue1;
  final int initValue2;

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  @override
  Widget build(BuildContext context) {
    int sortType = widget.initValue1;
    int order = widget.initValue2;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 170,
        height: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sort Type",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  RadioList(
                    listItem: const ["Size", "File Name", "Date"],
                    onTap: (value) {
                      sortType = value;
                      widget.onValueChange(sortType, order);
                    },
                    initValue: sortType,
                  ),
                  const Text(
                    "Order",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  RadioList(
                    listItem: const ["Ascending", "Descending"],
                    onTap: (value) {
                      order = value;
                      widget.onValueChange(sortType, order);
                    },
                    initValue: order,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                //add event
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                color: Colors.black54,
                size: 36,
              ),
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onDefault();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            padding: EdgeInsets.zero,
            fixedSize: const Size(135, 40),
          ),
          child: const Text(
            "SAVE AS DEFAULT",
            style: TextStyle(fontSize: 12),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            padding: EdgeInsets.zero,
            fixedSize: const Size(135, 40),
          ),
          child: const Text(
            "SAVE",
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
