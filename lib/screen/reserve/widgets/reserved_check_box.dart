import 'package:flutter/material.dart';

class ReservedCheckBox extends StatefulWidget {
  final String name;
  final bool value;
  final Function(bool?) onChanged;
  const ReservedCheckBox(
      {Key? key,
      required this.name,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  _ReservedCheckBoxState createState() => _ReservedCheckBoxState();
}

class _ReservedCheckBoxState extends State<ReservedCheckBox> {
  late bool checked;

  @override
  void initState() {
    checked = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(widget.name),
        contentPadding: const EdgeInsets.only(left: 0.0),
        controlAffinity: ListTileControlAffinity.leading,
        value: checked,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              checked = value;
              widget.onChanged(value);
            });
          }
        });
  }
}
