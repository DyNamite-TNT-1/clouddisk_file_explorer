import 'package:clouddisk_login_form/models/item.dart';
import 'package:flutter/material.dart';

class ItemFile extends StatelessWidget {
  final Folder item;
  final VoidCallback onPressed;

  const ItemFile({
    super.key,
    required this.item,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
          ),
        )),
        child: Row(
          children: [
            // Container(
            //   padding: const EdgeInsets.all(4),
            //   decoration: BoxDecoration(
            //     // borderRadius: BorderRadius.circular(12),
            //     shape: BoxShape.circle,
            //     // color: item is Folder ? ((item as Folder).color) : null,
            //   ),
            //   child: item is Folder
            //       ? Icon(
            //           (item as Folder).icon,
            //           color: Colors.white,
            //           size: 20,
            //         )
            //       : null,
            // ),
            const SizedBox(
              width: 8,
            ),
            Center(
              child: Text(
                item.text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff121212),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
