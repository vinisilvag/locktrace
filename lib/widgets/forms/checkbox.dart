import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatefulWidget {
  final String content;
  final bool checkBoxValue;
  final Function(bool?)? onChanged;

  const CustomCheckboxListTile({
    super.key,
    required this.content,
    required this.checkBoxValue,
    required this.onChanged,
  });

  @override
  State<CustomCheckboxListTile> createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.content,
        style: TextStyle(color: Color(0xFFA9AFB9), fontSize: 17),
      ),
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      value: widget.checkBoxValue,
      onChanged: widget.onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      side: const BorderSide(color: Color(0xFFA9AFB9), width: 2),
      activeColor: Color(0xFFFFC632),
      checkColor: Color(0xFF473404),
    );
  }
}
