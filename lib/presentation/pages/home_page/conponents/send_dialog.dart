import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SendDialog extends StatefulWidget {
  const SendDialog({super.key, required this.onSend});

  final Function(String, String) onSend;

  @override
  State<SendDialog> createState() => _SendDialogState();
}

class _SendDialogState extends State<SendDialog> {
  DateTime selectedDate = DateTime.now();
  TextEditingController countController = TextEditingController();
  @override
  void initState() {
    countController.text = "100";
    super.initState();
  }

  @override
  void dispose() {
    countController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      // helpText: 'Pick date',
      confirmText: 'OK',
      cancelText: 'Cancel',
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Cloud Disk",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Expired Date (NOT less than current date)",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            calendarMethod(context),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Download count (greater than 0)",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 36,
              child: TextFormField(
                controller: countController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 18,
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 4),
                  hintText: "100",
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "CANCEL",
            style: TextStyle(fontSize: 14),
          ),
        ),
        TextButton(
          onPressed: () {
            print("Selected Date: $selectedDate");
            print("Count: ${countController.text}");
            var miliseconds = selectedDate.millisecondsSinceEpoch;
            var seconds = miliseconds ~/ 1000;
            widget.onSend(countController.text, seconds.toString());
            Navigator.of(context).pop();
          },
          child: const Text(
            "OK",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  GestureDetector calendarMethod(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xffdcdcdc)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('dd/MM/yyyy').format(selectedDate),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff121212),
              ),
            ),
            const Icon(
              Icons.calendar_month_outlined,
              color: Colors.black,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
