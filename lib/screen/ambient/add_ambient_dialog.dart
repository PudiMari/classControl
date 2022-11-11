
import 'package:flutter/material.dart';

import '../../models/ambient/ambient.dart';
import '../../models/ambient/ambient_services.dart';

class AddAmbientDialog extends StatefulWidget {
  const AddAmbientDialog({Key? key}) : super(key: key);

  @override
  _AddAmbientDialogState createState() => _AddAmbientDialogState();
}

class _AddAmbientDialogState extends State<AddAmbientDialog> {
  String? ambientName;
  String status = '';

  final AmbientServices ambientServices = AmbientServices();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Ambiente'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Informe o nome do Ambiente'),
              onChanged: (text) => ambientName = text,
            ),
            RadioListTile(
              title: const Text('Disponível'),
              value: "Disponível",
              groupValue: status,
              onChanged: (value) {
                setState(() {
                  status = (value ?? '') as String;
                });
              },
            ),
            RadioListTile(
              title: const Text('Indisponível'),
              value: "Indisponível",
              groupValue: status,
              onChanged: (value) {
                setState(() {
                  status = (value ?? '') as String;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar')),
        TextButton(
            onPressed: () {
              if (ambientName != null && status.isNotEmpty) {
                debugPrint("botão adicionar");
                ambientServices.addAmbient(
                    Ambient(room: ambientName!, status: status));
                Navigator.of(context).pop();
              }
            },
            child: const Text('Adicionar')),
      ],
    );
  }
}
