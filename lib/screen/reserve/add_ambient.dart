
import 'package:flutter/material.dart';

import '../../models/reserve/ambient2.dart';
import '../../models/reserve/reserve2.dart';
import 'widgets/date_picker.dart';
import 'widgets/reserved_check_box.dart';
import 'widgets/user_text_field.dart';

class AddAmbient extends StatefulWidget {
  final Reserve2 reserve;
  final Function callback;
  const AddAmbient({Key? key, required this.reserve, required this.callback})
      : super(key: key);
  @override
  _AddAmbientState createState() => _AddAmbientState();
}

class _AddAmbientState extends State<AddAmbient> {
  final _formKey = GlobalKey<FormState>();

  late Reserve2 reserve;
  var mark = false;
  var ambient = '';
  late DateTime roomDate;

  @override
  void initState() {
    reserve = widget.reserve;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reservas'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              UserTextField(
                name: 'Reserva',
                initialValue: '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe descrição da área reservada';
                  }
                  return null;
                },
                inputType: TextInputType.text,
                onChanged: (value) {
                  if (value != null) {
                    ambient = value;
                  }
                },
              ),
              DatePicker(
                  name: 'Date',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a data da reserva';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    roomDate = text;
                  }),
              ReservedCheckBox(
                  name: 'Realizada',
                  value: mark,
                  onChanged: (text) {
                    mark = text ?? mark;
                  }),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                Navigator.of(context).pop();
                final newRoom =
                    Ambient2(ambient, date: roomDate, done: mark);
                reserve.rooms.add(newRoom);
              }
              widget.callback();
            },
            child: const Text('Adicionar')),
      ],
    );
  }
}
