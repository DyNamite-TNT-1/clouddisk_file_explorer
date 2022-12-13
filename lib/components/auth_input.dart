import 'package:flutter/material.dart';

class AuthInput extends StatefulWidget {
  const AuthInput({
    Key? key,
    required this.domainController,
    required this.label,
    required this.icon,
    required this.keyboardType,
    required this.isPassword,
  }) : super(key: key);

  final TextEditingController domainController;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isPassword;

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool isVisible = false;
  @override
  void initState() {
    isVisible = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.blue),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4, right: 12),
            child: Icon(
              widget.icon,
              size: 20,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: widget.domainController,
              keyboardType: widget.keyboardType,
              obscureText: isVisible,
              style: const TextStyle(
                fontSize: 20,
              ),
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: widget.label,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: const EdgeInsets.only(top: -6, bottom: 4),
                border: InputBorder.none,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        color: Colors.black,
                        icon: isVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () => {
                          setState(() {
                            isVisible = !isVisible;
                          })
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
