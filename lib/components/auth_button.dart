import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);
  final String label;
  final VoidCallback onTap;

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  Color color = Colors.blue.shade700;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        onTapDown: (_) {
          setState(() {
            {
              color = Colors.blue.shade400;
            }
          });
        },
        onTapUp: (_) {
          setState(() {
            color = Colors.blue.shade700;
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color,
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
