
import 'package:flutter/material.dart';

import '../../models/reserve/reserve2.dart';
import '../../models/reserve/reserve_services2.dart';

/*
 essa pagina fica; deve adicionar a descrição e fazer ela ser listada no inicio tbm
 como no codigo simplao


*/

class AddReserveDialog extends StatefulWidget {
  const AddReserveDialog({Key? key}) : super(key: key);

  @override
  _AddReserveDialogState createState() => _AddReserveDialogState();
}

class _AddReserveDialogState extends State<AddReserveDialog> {
  String? reserveName;
  String? descriptionName;
  String character = '';

  final ReserveServices2 repository = ReserveServices2();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Reserva'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Entre com a identificação da reserva'),
              onChanged: (text) => reserveName = text,
            ),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Descrição'),
              onChanged: (text) => descriptionName = text,
            ),
            // para cá seria interessante colocar a data daquela reserva lá da frente, da página inicial
            RadioListTile(
              title: const Text('Salão de Festa'),
              value: 'festa',
              groupValue: character,
              onChanged: (value) {
                setState(() {
                  character = (value ?? '') as String;
                });
              },
            ),
            RadioListTile(
              title: const Text('Cerimonial'),
              value: 'cerimonial',
              groupValue: character,
              onChanged: (value) {
                setState(() {
                  character = (value ?? '') as String;
                });
              },
            ),
            RadioListTile(
              title: const Text('Outro'),
              value: 'outro',
              groupValue: character,
              onChanged: (value) {
                setState(() {
                  character = (value ?? '') as String;
                });
              },
            )
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
              if (reserveName != null && character.isNotEmpty) {
                repository.addReserve(
                    Reserve2(reserveName!, type: character, rooms: []));
                Navigator.of(context).pop();
              }
            },
            child: const Text('Adicionar')),
      ],
    );
  }
}
