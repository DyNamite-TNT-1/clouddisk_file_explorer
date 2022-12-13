import 'package:flutter/material.dart';

class ItemLeading extends StatelessWidget {
  const ItemLeading({
    Key? key,
    required this.icon,
    required this.content,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final String content;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey.shade700,
            ),
            const SizedBox(
              width: 24,
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
