import 'package:flutter/material.dart';

class RadioList extends StatefulWidget {
  const RadioList({
    Key? key,
    required this.listItem,
    required this.onTap,
    required this.initValue,
  }) : super(key: key);
  final List<String> listItem;
  final void Function(int) onTap;
  final int initValue;
  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  int selectedRadio = 0;
  @override
  void initState() {
    selectedRadio = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.listItem.map((item) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedRadio = widget.listItem.indexOf(item);
              widget.onTap(selectedRadio);
            });
          },
          child: Row(
            children: [
              Radio(
                value: widget.listItem.indexOf(item),
                groupValue: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio = value!;
                    widget.onTap(selectedRadio);
                  });
                },
              ),
              SizedBox(
                width: 180,
                child: Text(item),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
